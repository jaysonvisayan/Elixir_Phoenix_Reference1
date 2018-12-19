defmodule Data.Contexts.PlanContext do
  @moduledoc false

  alias Data.{
    Repo,
    Contexts.UtilityContext,
    Schemas.Exclusion,
    Schemas.Facility,
    Schemas.Plan,
    Schemas.PlanBenefit,
    Schemas.PlanCoverage,
    Schemas.PlanCoverageRiskShareFacilities,
    Schemas.PlanExclusion,
    Schemas.PlanHoed,
    Schemas.PlanLimit,
    Schemas.PlanPreExistingCondition
  }

  alias Ecto.Changeset

  import Ecto.Query

  def validate_params(:search, params) do
    fields = %{
      page_number: :integer,
      search_value: :string,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :page_number,
        :display_per_page,
        :sort_by,
        :order_by
      ],
        message: "is required")
    {changeset.valid?, changeset}

  end

  def validate_params(:view, params) do

    fields = %{
      code: :string,
      tab: :string,
      exclusion: :map,
      pec: :map,
      benefit: :map,
      coverage: :map
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:code], message: "is invalid")
    |> tab_to_lowercase()
    |> Changeset.validate_inclusion(:tab, [
      "exclusion",
      "benefit",
      "coverage",
      "condition",
    ], message: "input is invalid")
    |> validate_tab(:tab, params)
    |> is_valid_changeset?()
  end

  def get_plan({:error, changeset}, :view), do: {:error, changeset}

  def get_plan(params, :view), do: check_plan_tab(Map.has_key?(params, :tab), params, :view)

  def check_plan_tab(true, params, :view), do: get_plan(params.tab, params, :view)

  def check_plan_tab(false, params, :view), do: get_plan(false, params, :view)

  def get_plan(false, params, :view) do
    params
    |> get_all_plan()
    |> existing_params?("all_params.json")
  end

  def get_plan(nil, params, :view) do
    params
    |> get_all_plan()
    |> existing_params?("all_params.json")
  end

  def get_plan("", params, :view) do
    params
    |> get_all_plan()
    |> existing_params?("all_params.json")
  end

  def get_plan("exclusion", params, :view) do
    params
    |> get_plan_exclusion()
  end

  def get_plan("benefit", params, :view) do
    params
    |> get_plan_benefit()
  end

  def get_plan("coverage", params, :view) do
    params
    |> get_plan_coverage()
  end

  def get_plan("condition", params, :view) do
    params
    |> get_plan_condition()
  end

  def validate_params(:create_medical, params) do
    fields = %{
      is_hospital_bill: :boolean,
      is_no_outright_denial: :boolean,
      is_loa_facilitated: :boolean,
      is_professional_fee: :boolean,
      is_sonny_medina: :boolean,
      is_reimbursement: :boolean,
      phic_status: :string,
      application_of_limit: :string,
      principal_schedule: :string,
      applicability: :string,
      description: :string,
      dependent_schedule: :string,
      grace_dependent_type: :string,
      classification: :string,
      grace_principal_type: :string,
      default_effective_date: :string,
      name: :string,
      type: :string,
      code: :string,
      max_no_dependents: :integer,
      grace_principal_value: :integer,
      grace_dependent_value: :integer,
      loa_validity: :integer,
      plan_coverages: {:array, :map},
      plan_age_eligibilities: {:array, :map},
      plan_benefits: {:array, :map},
      plan_hoed: {:array, :map},
      plan_limits: {:array, :map},
      plan_pecs: {:array, :map},
      exclusion_codes: {:array, :string}
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required(Map.keys(fields), message: "is required")

    {changeset.valid?, changeset}
  end

  def get_plans({:error, changeset}), do: {:error, changeset}
  def get_plans(params) do
    search_value = if Map.has_key?(params, :search_value), do: params.search_value, else: ""
    offset = (params.page_number * params.display_per_page) - params.display_per_page
    Plan
    |> where([p],
      ilike(p.code, ^"%#{search_value}%") or
      ilike(p.name, ^"%#{search_value}%") or
      ilike(p.category, ^"%#{search_value}%") or
      ilike(p.type, ^"%#{search_value}%") or
      ilike(p.updated_by, ^"%#{search_value}%") or
      ilike(fragment("to_char(?, 'Mon-dd-yyyy')", p.updated_at), ^"%#{search_value}%")
    )
    |> select([p],
      %{
        code: p.code,
        name: p.name,
        category: p.category,
        type: p.type,
        updated_at: p.updated_at,
        updated_by: p.updated_by
      }
    )
    |> order_datatable(
      params.sort_by,
      params.order_by
    )
    |> offset(^offset)
    |> limit(^params.display_per_page)
    |> Repo.all()
  end

  # Ascending
  defp order_datatable(query, nil, nil), do: query
  defp order_datatable(query, "", ""), do: query
  defp order_datatable(query, "code", "asc"), do: query |> order_by([p], asc: p.code)
  defp order_datatable(query, "name", "asc"), do: query |> order_by([p], asc: p.name)
  defp order_datatable(query, "category", "asc"), do: query |> order_by([p], asc: p.category)
  defp order_datatable(query, "type", "asc"), do: query |> order_by([p], asc: p.type)
  defp order_datatable(query, "updated_at", "asc"), do: query |> order_by([p], asc: p.updated_at)
  defp order_datatable(query, "updated_by", "asc"), do: query |> order_by([p], asc: p.updated_by)

  # Descending
  defp order_datatable(query, "code", "desc"), do: query |> order_by([p], desc: p.code)
  defp order_datatable(query, "name", "desc"), do: query |> order_by([p], desc: p.name)
  defp order_datatable(query, "category", "desc"), do: query |> order_by([p], desc: p.category)
  defp order_datatable(query, "type", "desc"), do: query |> order_by([p], desc: p.type)
  defp order_datatable(query, "updated_at", "desc"), do: query |> order_by([p], desc: p.updated_at)
  defp order_datatable(query, "updated_by", "desc"), do: query |> order_by([p], desc: p.updated_by)

  #For Seed

  def insert_plan_seed(params) do
    params
    |> plan_get_by()
    |> create_update_plan(params)
  end

  defp create_update_plan(nil, params) do
    %Plan{}
    |> Plan.changeset(params)
    |> Repo.insert()
  end

  defp create_update_plan(plan, params) do
    plan
    |> Plan.changeset(params)
    |> Repo.update()
  end

  defp plan_get_by(params) do
    Plan |> Repo.get_by(params)
  end

  defp is_valid_changeset?(changeset), do: {changeset.valid?, changeset}

  def get_all_plan(params) do
    Plan
    |> where([p], fragment("LOWER(?)", p.code) == fragment("LOWER(?)", ^params.code))
    |> Repo.one()
    |> get_exclusion()
    |> get_pre_existing_condition()
    |> get_benefit()
    |> get_limit()
    |> get_coverage()
    |> get_risk_share()
    |> get_facility()
    |> get_condition()
  end

  def get_exclusion(struct) do
    exclusions =
      Exclusion
    |> where([e], e.code in ^struct.exclusion_codes)
    |> select([e], %{
        code: e.code,
        name: e.name,
        type: e.type
    })
    |> Repo.all()

    struct |> Map.put(:exclusions, exclusions)
  end

  def get_pre_existing_condition(struct) do
    struct
    |> Repo.preload([
        plan_pre_existing_conditions:
        from(pec in PlanPreExistingCondition, where: pec.plan_code == ^struct.code)
    ])
  end

  def get_benefit(struct) do
    struct
    |> Repo.preload([
        plan_benefits:
        from(pb in PlanBenefit, where: pb.plan_code == ^struct.code)
    ])
  end

  def get_limit(struct) do
    struct
    |> Repo.preload([
        plan_limits:
        from(pl in PlanLimit, where:
        fragment("LOWER(?)", pl.plan_code) == fragment("LOWER(?)", ^struct.code))
    ])
  end

  def get_coverage(struct) do
    struct
    |> Repo.preload([
        plan_coverages: from(pc in PlanCoverage, where: pc.plan_code == ^struct.code)
    ])
  end

  def get_risk_share(struct) do
    pc =
    struct.plan_coverages
    |> Enum.map(fn(pc) -> pc.id end)

    risk_shares =
    PlanCoverageRiskShareFacilities
    |> where([pcrsf], fragment("CAST(? AS TEXT)", pcrsf.plan_coverage_id) in ^pc)
    |> select([pcrsf], %{
        facility_code: pcrsf.facility_code,
        risk_share_type: pcrsf.risk_share_type,
        risk_share_value: pcrsf.risk_share_value,
        rs_member_pays_handling: pcrsf.rs_member_pays_handling
    })
    |> Repo.all()

    struct |> Map.put(:risk_shares, risk_shares)
  end

  def get_facility(struct) do
    fcodes =
      struct.risk_shares
      |> Enum.into([], &(&1.facility_code))
      |> Enum.uniq()

   facilities =
    Facility
    |> where([f], f.code in ^fcodes)
    |> select([f], %{
        code: f.code,
        name: f.name,
        type: f.type
    })
    |> Repo.one()

    struct |> Map.put(:facilities, facilities)
  end

  def get_condition(struct) do
    struct
    |> Repo.preload([
        plan_hoed: from(ph in PlanHoed, where: ph.plan_code == ^struct.code)
    ])
  end

  def get_plan_exclusion(params) do
    params
    |> get_all_data_exclusion()
    |> existing_params?("exclusion_tab.json")
  end

  defp get_all_data_exclusion(params) do

    pec_search_value =
      if params.pec["search_value"] == "" do
        ""
      else
        params.pec["search_value"]
      end

    pec_offset = (params.pec["page_number"] * params.pec["display_per_page"]) - params.pec["display_per_page"]
    pec_limit = params.pec["display_per_page"]

    exc_search_value =
      if params.exclusion["search_value"] == "" do
        ""
      else
        params.exclusion["search_value"]
      end

    exc_offset = (params.exclusion["page_number"] * params.exclusion["display_per_page"]) - params.exclusion["display_per_page"]
    exc_limit = params.exclusion["display_per_page"]

    Plan
    |> where([p], fragment("LOWER(?)", p.code) == fragment("LOWER(?)", ^params.code))
    |> Repo.one()
    |> exclusion_query(exc_search_value, exc_offset, exc_limit)
    |> pre_existing_query(pec_search_value, pec_offset, pec_limit)
  end

  defp exclusion_query(struct, search_value, offset, limit) do
    Exclusion
    |> where([e],
        ilike(e.code, ^"%#{search_value}%") or
        ilike(e.name, ^"%#{search_value}%") or
        ilike(e.type, ^"%#{search_value}%")
    )
    |> exclusion_query(struct, offset, limit, :select)
  end

  defp exclusion_query(struct, nil, offset, limit) do
    Exclusion
    |> where([e], e.code in ^struct.exclusion_codes)
    |> exclusion_query(struct, offset, limit, :select)
  end

  defp exclusion_query(struct, "", offset, limit) do
    Exclusion
    |> where([e], e.code in ^struct.exclusion_codes)
    |> exclusion_query(struct, offset, limit, :select)
  end

  defp exclusion_query(exclusion, struct, offset, limit, :select) do
    exclusions =
      exclusion
      |> select([e], %{
          code: e.code,
          name: e.name,
          type: e.type
      })
      |> offset(^offset)
      |> limit(^limit)
      |> Repo.all()

    struct |> Map.put(:exclusions, exclusions)
  end

  defp pre_existing_query(struct, search_value, offset, limit) do
    struct
    |> Repo.preload([
        plan_pre_existing_conditions: from(pec in PlanPreExistingCondition, where:
         ilike(pec.pec_code, ^"%#{search_value}%") or
         ilike(pec.member_type, ^"%#{search_value}%") or
         ilike(pec.disease_category, ^"%#{search_value}%") or
         ilike(fragment("CAST(? AS TEXT)", pec.duration), ^"%#{search_value}%") or
         ilike(pec.inner_limit_type, ^"%#{search_value}%") or
         ilike(fragment("CAST(? AS TEXT)", pec.inner_limit_value), ^"%#{search_value}%"),
         offset: ^offset,
         limit: ^limit)
    ])
  end

  def get_plan_benefit(params) do
    params
    |> get_all_data_benefit()
    |> existing_params?("benefit_tab.json")
  end

  def get_all_data_benefit(params) do

    search_value =
      if params.benefit["search_value"] == "" do
        ""
      else
        params.benefit["search_value"]
      end

    offset = (params.benefit["page_number"] * params.benefit["display_per_page"]) - params.benefit["display_per_page"]
    limit = params.benefit["display_per_page"]

    Plan
    |> where([p], fragment("LOWER(?)", p.code) == fragment("LOWER(?)", ^params.code))
    |> Repo.one()
    |> plan_benefit_query(search_value, offset, limit)
    |> plan_limit_query()
  end

  def plan_benefit_query(struct, search_value, offset, limit) do
    struct
    |> Repo.preload([
      plan_benefits: from(pb in PlanBenefit, where:
         ilike(pb.benefit_code, ^"%#{search_value}%") or
         ilike(pb.limit_type, ^"%#{search_value}%") or
         ilike(fragment("CAST(? AS TEXT)", pb.limit_value), ^"%#{search_value}%"),
         offset: ^offset,
         limit: ^limit)
    ])
  end

  def plan_limit_query(struct) do
    struct
    |> Repo.preload([
        plan_limits: from(pl in PlanLimit, where:
        fragment("LOWER(?)", pl.plan_code) == fragment("LOWER(?)", ^struct.code))
    ])
  end

  def get_plan_coverage(params) do
    params
    |> get_all_data_coverage()
    |> existing_params?("coverage_tab.json")
  end

  defp get_all_data_coverage(params) do

    facility_search_value =
      if params.coverage["facility"]["search_value"] == "" do
        ""
      else
        params.coverage["facility"]["search_value"]
      end

    facility_offset =
      params.coverage["facility"]["page_number"]
      |> Kernel.*(params.coverage["facility"]["display_per_page"])
      |> Kernel.-(params.coverage["facility"]["display_per_page"])
    facility_limit = params.coverage["facility"]["display_per_page"]

    risk_share_search_value =
      if params.coverage["risk_share"]["search_value"] == "" do
        ""
      else
        params.coverage["risk_share"]["search_value"]
      end

    risk_share_offset =
      params.coverage["risk_share"]["page_number"]
      |> Kernel.* (params.coverage["risk_share"]["display_per_page"])
      |> Kernel.- (params.coverage["risk_share"]["display_per_page"])
    risk_share_limit = params.coverage["risk_share"]["display_per_page"]

    Plan
    |> where([p], fragment("LOWER(?)", p.code) == fragment("LOWER(?)", ^params.code))
    |> Repo.one()
    |> coverage_query()
    |> facility_query(facility_search_value, facility_offset, facility_limit)
    |> risk_share_specific_query(risk_share_search_value, risk_share_offset, risk_share_limit)
  end

  def coverage_query(struct) do
    struct
    |> Repo.preload([
        plan_coverages: from(pc in PlanCoverage, where:
        fragment("LOWER(?)", pc.plan_code) == fragment("LOWER(?)", ^struct.code))
    ])
  end

  defp facility_query(struct, search_value, offset, limit) do
    Facility
    |> where([f],
        ilike(f.code, ^"%#{search_value}%") or
        ilike(f.name, ^"%#{search_value}%") or
        ilike(f.type, ^"%#{search_value}%")
    )
    |> facility_query(struct, offset, limit, :select)
  end

  defp facility_query(struct, nil, offset, limit) do
    Facility
    |> where([f], f)
    |> facility_query(struct, offset, limit, :select)
  end

  defp facility_query(struct, "", offset, limit) do
    Facility
    |> where([f], f)
    |> facility_query(struct, offset, limit, :select)
  end

  defp facility_query(facility, struct, offset, limit, :select) do
    facilities =
      facility
      |> select([f], %{
          code: f.code,
          name: f.name,
          type: f.type
      })
      |> Repo.one()

    if is_nil(facilities), do: Map.put(struct, :facilities, []), else: Map.put(struct, :facilities, facilities)
  end

  defp risk_share_specific_query(struct, search_value, offset, limit) do
    PlanCoverageRiskShareFacilities
    |> where([pcrsf],
         ilike(pcrsf.facility_code, ^"%#{search_value}%") or
         ilike(pcrsf.risk_share_type, ^"%#{search_value}%") or
         ilike(fragment("CAST(? AS TEXT)", pcrsf.risk_share_value), ^"%#{search_value}%")
    )
    |> risk_share_specific_query(struct, offset, limit, :select)
  end

  defp risk_share_specific_query(struct, nil, offset, limit) do
    PlanCoverageRiskShareFacilities
    |> where([pcrsf], pcrsf.facility_code == ^struct.facilities.code)
    |> risk_share_specific_query(struct, offset, limit, :select)
  end

  defp risk_share_specific_query(struct, "", offset, limit) do
    PlanCoverageRiskShareFacilities
    |> where([pcrsf], pcrsf.facility_code == ^struct.facilities.code)
    |> risk_share_specific_query(struct, offset, limit, :select)
  end

  defp risk_share_specific_query(risk_share, struct, offset, limit, :select) do
    risk_shares =
      risk_share
      |> select([pcrsf], %{
        facility_code: pcrsf.facility_code,
        risk_share_type: pcrsf.risk_share_type,
        risk_share_value: pcrsf.risk_share_value,
        rs_member_pays_handling: pcrsf.rs_member_pays_handling
      })
      |> offset(^offset)
      |> limit(^limit)
      |> Repo.all()

    struct |> Map.put(:risk_shares, risk_shares)
  end

  def get_plan_condition(params) do
    params
    |> get_all_data_condition()
    |> existing_params?("condition_tab.json")
  end

  defp get_all_data_condition(params) do
    Plan
    |> where([p], fragment("LOWER(?)", p.code) == fragment("LOWER(?)", ^params.code))
    |> Repo.one()
    |> condition_query()
  end

  defp condition_query(struct) do
    struct
    |> Repo.preload([
        plan_hoed: from(ph in PlanHoed, where: ph.plan_code == ^struct.code)
    ])
  end

  defp tab_to_lowercase(changeset), do: changeset |> Changeset.put_change(:tab, String.downcase(changeset.changes.tab))

  defp existing_params?(params, _json_name) when is_nil(params), do: {:error_message, "code entered is invalid"}
  defp existing_params?(params, json_name), do: {params, json_name}

  defp validate_tab(changeset, key, params) do
    if Map.has_key?(changeset.changes, key) do
      case changeset.changes[key] do
        "exclusion" ->
          changeset
          |> validate_pec_params(params)
          |> validate_exclusion_params(params)
        "benefit" ->
          changeset
          |> validate_benefit_params(params)
        "coverage" ->
          changeset
          |> validate_facility_params(params)
          |> validate_risk_share_params(params)
        "condition" ->
          changeset
        _ ->
          changeset
      end
      else
          changeset
    end
  end

  defp validate_pec_params(changeset, params) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    changeset_pec = {%{}, fields}
    |> Changeset.cast(params["pec"], Map.keys(fields))
    |> Changeset.validate_required([
      :page_number,
      :display_per_page,
      :sort_by,
      :order_by
    ], message: "is invalid in exclusion tab")

    if changeset_pec.valid? do
      changeset
    else
      errors = changeset.errors ++ add_field_name_in_error(changeset_pec.errors, "pec")

      changeset
      |> Map.put(:errors, errors)
      |> Map.put(:valid?, false)
    end
  end

  defp validate_exclusion_params(changeset, params) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }
    changeset_exclusion = {%{}, fields}
    |> Changeset.cast(params["exclusion"], Map.keys(fields))
    |> Changeset.validate_required([
      :page_number,
      :display_per_page,
      :sort_by,
      :order_by
    ], message: "is invalid")

    if changeset_exclusion.valid? do
      changeset
    else
      errors = changeset.errors ++ add_field_name_in_error(changeset_exclusion.errors, "exclusion")

      changeset
      |> Map.put(:errors, errors)
      |> Map.put(:valid?, false)
    end
  end

  defp validate_benefit_params(changeset, params) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }
    changeset_benefit = {%{}, fields}
    |> Changeset.cast(params["benefit"], Map.keys(fields))
    |> Changeset.validate_required([
      :page_number,
      :display_per_page,
      :sort_by,
      :order_by
    ], message: "is invalid")

    if changeset_benefit.valid? do
      changeset
    else
      errors = changeset.errors ++ add_field_name_in_error(changeset_benefit.errors, "benefit")

      changeset
      |> Map.put(:errors, errors)
      |> Map.put(:valid?, false)
    end
  end

  defp validate_facility_params(changeset, params) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    changeset_facility =
      {%{}, fields}
      |> Changeset.cast(params["coverage"]["facility"], Map.keys(fields))
      |> Changeset.validate_required([
        :page_number,
        :display_per_page,
        :sort_by,
        :order_by
      ], message: "is invalid in coverage tab")

    if changeset_facility.valid? do
      changeset
    else
      errors = changeset.errors ++ add_field_name_in_error(changeset_facility.errors, "facility")

      changeset
      |> Map.put(:errors, errors)
      |> Map.put(:valid?, false)
    end
  end

  defp validate_risk_share_params(changeset, params) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }
    changeset_risk_share = {%{}, fields}
    |> Changeset.cast(params["coverage"]["risk_share"], Map.keys(fields))
    |> Changeset.validate_required([
      :page_number,
      :display_per_page,
      :sort_by,
      :order_by
    ], message: "is invalid in coverage tab")

    if changeset_risk_share.valid? do
      changeset
    else
      errors = changeset.errors ++ add_field_name_in_error(changeset_risk_share.errors, "risk_share")

      changeset
      |> Map.put(:errors, errors)
      |> Map.put(:valid?, false)
    end
  end

  defp add_field_name_in_error(errors, tab_name) do
    Enum.into(errors, [], fn({key, {message, opts}}) ->
      {"#{key} (#{tab_name})", {"#{message}", opts}}
    end)
  end
end
