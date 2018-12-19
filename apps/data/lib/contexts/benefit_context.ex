defmodule Data.Contexts.BenefitContext do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query

  alias Data.{
    Repo,
    Schemas.Benefit,
    Schemas.BenefitLimit,
    Schemas.Package
  }

  def validate_params(:view, params) do
    fields = %{
      code: :string
    }

    {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([:code], message: "is required")
      |> is_valid_changeset?()
  end

  def validate_params(:search, params) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([:page_number, :display_per_page, :sort_by, :order_by], message: "is required")
      |> lower_value(:sort_by)
      |> lower_value(:order_by)
      |> Changeset.validate_inclusion(:sort_by, ["name", "type", "code", "coverages", "updated_at", "updated_by"], message: "is invalid")
      |> Changeset.validate_inclusion(:order_by, ["asc", "desc"], message: "is invalid")
      |> validate_key(params["search_value"])
      |> is_valid_changeset?()
  end

  def validate_params(:create, params) do
    fields = %{
      code: :string,
      name: :string,
      category: :string,
      frequency: :string,
      acu_type: :string,
      acu_type_coverage: :string,
      risk_share: :string,
      member_pays_handling: :string,
      is_loa_facilitated: :boolean,
      is_reimbursement: :boolean,
      is_hospital: :boolean,
      is_clinic: :boolean,
      is_mobile: :boolean,
      all_diagnosis: :boolean,
      all_procedure: :boolean,
      risk_share_amount: :decimal,
      packages: {:array, :string},
      limit: {:array, :map}
    }

    changeset =
      {%{}, fields}
        |> Changeset.cast(params, Map.keys(fields))
        |> Benefit.changeset_acu()
        |> validate_code()
        |> availment_validations()

    {changeset.valid?, changeset}
  end

  def is_valid_changeset?(changeset), do: {changeset.valid?, changeset}

  defp lower_value(changeset, key) do
    with true <- Map.has_key?(changeset.changes, key) do
      string =
        changeset.changes[key]
        |> String.split(" ")
        |> Enum.map(&(String.downcase(&1)))
        |> Enum.join(" ")
      changeset
      |> Changeset.put_change(key, string)
    else
      _ ->
        changeset
    end
  end

  def get_benefits({:error, changeset}, _), do: {:error, changeset}
  def get_benefits(params, :search) do
    search_value = if Map.has_key?(params, :search_value), do: params.search_value, else: ""
    offset = (params.page_number * params.display_per_page) - params.display_per_page

    initialize_query()
    |> where([b, bl],
      ilike(b.code, ^"%#{search_value}%") or
      ilike(b.name, ^"%#{search_value}%") or
      ilike(b.type, ^"%#{search_value}%") or
      ilike(fragment("array_to_string(?, ',')", bl.coverage_codes), ^"%#{search_value}%") or
      ilike(fragment("CAST(? AS TEXT)", b.updated_at), ^"%#{search_value}%") or
      ilike(b.updated_by, ^"%#{search_value}%")
      )
    |> select([b, bl],
      %{
        code: b.code,
        name: b.name,
        type: b.type,
        coverages: bl.coverage_codes,
        updated_at: b.updated_at,
        updated_by: b.updated_by
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

  def get_benefit_acu({:error, changeset}, _), do: {:error, changeset}
  def get_benefit_acu(params, :view) do
    Benefit
    |> Repo.get_by(params)
    |> Repo.preload(:benefit_limits)
  end

  # For Seed

  def insert_benefit_seed(params) do
    params
    |> get_by()
    |> create_update_benefit(params)
  end

  defp create_update_benefit(nil, params) do
    %Benefit{}
    |> Benefit.changeset_create(params)
    |> Repo.insert()
  end

  defp create_update_benefit(benefit, params) do
    benefit
    |> Benefit.changeset_update(params)
    |> Repo.update()
  end

  def insert_benefit_limit_seed(params) do
    params
    |> get_benefit_limit_by()
    |> create_update_benefit_limit(params)
  end

  defp create_update_benefit_limit(nil, params) do
    %BenefitLimit{}
    |> BenefitLimit.changeset(params)
    |> Repo.insert()
  end

  defp create_update_benefit_limit(benefit_limit, params) do
    benefit_limit
    |> BenefitLimit.changeset(params)
    |> Repo.update()
  end

  defp initialize_query do
    Benefit
    |> join(:inner, [b], bl in BenefitLimit, on: b.code == bl.benefit_code)
  end

  #Ascending
  defp order_datatable(query, nil, nil), do: query
  defp order_datatable(query, "", ""), do: query
  defp order_datatable(query, "code", "asc"), do: query |> order_by([b, bl], asc: b.code)
  defp order_datatable(query, "name", "asc"), do: query |> order_by([b, bl], asc: b.name)
  defp order_datatable(query, "type", "asc"), do: query |> order_by([b, bl], asc: b.type)
  defp order_datatable(query, "coverages", "asc"), do: query |> order_by([b, bl], asc: fragment("array_to_string(?, ',')", bl.coverage_codes))
  defp order_datatable(query, "updated_at", "asc"), do: query |> order_by([b, bl], asc: b.updated_at)
  defp order_datatable(query, "updated_by", "asc"), do: query |> order_by([b, bl], asc: b.updated_by)

  # Descending
  defp order_datatable(query, "", ""), do: query
  defp order_datatable(query, "code", "desc"), do: query |> order_by([b, bl], desc: b.code)
  defp order_datatable(query, "name", "desc"), do: query |> order_by([b, bl], desc: b.name)
  defp order_datatable(query, "type", "desc"), do: query |> order_by([b, bl], desc: b.type)
  defp order_datatable(query, "coverages", "desc"), do: query |> order_by([b, bl], desc: fragment("array_to_string(?, ',')", bl.coverage_codes))
  defp order_datatable(query, "updated_at", "desc"), do: query |> order_by([b, bl], desc: b.updated_at)
  defp order_datatable(query, "updated_by", "desc"), do: query |> order_by([b, bl], desc: b.updated_by)

  defp validate_key(changeset, ""), do: changeset |> Changeset.put_change(:search_value, "")
  defp validate_key(changeset, nil), do: changeset |> Changeset.add_error(:search_value, "is not in the parameters")
  defp validate_key(changeset, _params), do: changeset |> validate_search_value(changeset.changes)

  defp validate_search_value(changeset, changes) when map_size(changes) == 0 do
    changeset
    |> Changeset.add_error(:search_value, "is not in the parameters")
  end
  defp validate_search_value(changeset, _changes), do: changeset

  defp get_by(%{code: code} = _params) do
    Benefit |> Repo.get_by(code: code)
  end

  defp get_benefit_limit_by(params) do
    BenefitLimit |> Repo.get_by(params)
  end

  defp validate_code(changeset) do
    changeset
    |> check_errors(:code)
    |> validate_code(changeset)
  end

  defp validate_code(true, changeset), do: changeset
  defp validate_code(false, changeset) do
    Benefit
    |> where([b], fragment("LOWER(?)", b.code) == fragment("LOWER(?)", ^changeset.changes.code))
    |> select([b], count(b.code))
    |> Repo.one()
    |> validate_code(changeset)
  end

  defp validate_code(0, changeset), do: changeset
  defp validate_code(_, changeset) do
    Changeset.add_error(changeset, :code, "is already taken")
  end

  defp availment_validations(changeset) do
    changeset
    |> check_errors(:category)
    |> availment_validations(changeset)
  end

  defp availment_validations(true, changeset), do: changeset
  defp availment_validations(false, changeset) do
    changeset.changes.category
    |> String.downcase()
    |> availment_validations(changeset)
  end

  defp availment_validations("p", changeset), do: changeset
  defp availment_validations(_, changeset) do
    changeset
    |> Benefit.changeset_availment()
    |> validate_packages()
    |> validate_amount()
    |> validate_limit()
  end

  defp validate_packages(changeset) do
    changeset
    |> check_errors(:packages)
    |> validate_packages(changeset)
  end

  defp validate_packages(true, changeset), do: changeset
  defp validate_packages(false, changeset) do
    Package
    |> select([p], p.code)
    |> Repo.all()
    |> validate_packages(changeset)
  end

  defp validate_packages([], changeset) do
    Changeset.add_error(
      changeset,
      :packages,
      "not existing: #{Enum.join(changeset.changes.packages, ",")}"
    )
  end

  defp validate_packages(codes, changeset) when is_list(codes) do
      errors = Enum.reject(changeset.changes.packages, &(Enum.member?(codes, &1)))
      validate_packages(changeset, errors)
    rescue
       KeyError ->
        changeset
  end

  defp validate_packages(changeset, []), do: changeset
  defp validate_packages(changeset, errors) do
    Changeset.add_error(
      changeset,
      :packages,
      "not existing: #{Enum.join(errors, ",")}"
    )
  end

  defp validate_amount(changeset) do
    changeset
    |> check_errors(:risk_share_amount)
    |> validate_amount(changeset)
  end

  defp validate_amount(true, changeset), do: changeset
  defp validate_amount(false, changeset) do
    Changeset.update_change(
      changeset,
      :risk_share_amount,
      &(Decimal.new(&1))
    )
  end

  defp validate_limit(changeset) do
      changeset
      |> validate_limit(
          Enum.empty?(changeset.changes.limit),
          Enum.with_index(changeset.changes.limit, 1)
        )
    rescue
       KeyError ->
        changeset
       _ ->
        changeset
        |> Changeset.add_error(:limit, "is required")
  end

  defp validate_limit(changeset, true, []) do
    changeset
    |> Changeset.add_error(:limit, "is required")
  end

  defp validate_limit(changeset, false, []), do: changeset
  defp validate_limit(changeset, false, [{head, index} | tails]) do
    fields = %{
      limit_type: :string,
      limit_value: :string
    }

    changeset_limit =
      {%{}, fields}
        |> Changeset.cast(head, Map.keys(fields))
        |> Changeset.validate_required(Map.keys(fields), message: "is required")
        |> Changeset.validate_inclusion(:limit_type, ["S", "PS"], message: "is invalid")
        |> validate_limit_value()
        |> validate_limit_value_length()

    if changeset_limit.valid? do
      validate_limit(changeset, false, tails)
    else
      errors = changeset.errors ++ add_index_in_error(changeset_limit.errors, index)

      changeset
      |> Map.put(:errors, errors)
      |> Map.put(:valid?, false)
      |> validate_limit(false, tails)
    end
  end

  defp validate_limit_value(changeset) do
    changeset
    |> check_errors(:limit_value)
    |> validate_limit_value(changeset)
  end

  defp validate_limit_value(true, changeset), do: changeset
  defp validate_limit_value(false, changeset), do: to_integer(changeset)

  defp to_integer(changeset) do
      changeset
      |> Changeset.update_change(
          :limit_value,
          &(String.to_integer(&1))
        )
    rescue
       _ ->
        to_float(changeset)
  end

  defp to_float(changeset) do
    if Regex.match?(~r/^[0-9.]*$/, changeset.changes.limit_value) do
      changeset.changes.limit_value
      |> Float.parse()
      |> to_float(changeset)
    else
      changeset
      |> Changeset.add_error(:limit_value, "is invalid")
    end
  end

  defp to_float(:error, changeset) do
    changeset
    |> Changeset.add_error(:limit_value, "is invalid")
  end

  defp to_float(_, changeset), do: changeset

  defp validate_limit_value_length(changeset) do
    limit_type = check_errors(changeset, :limit_type)
    limit_value = check_errors(changeset, :limit_value)

    [limit_type, limit_value]
    |> Enum.member?(true)
    |> validate_limit_value_length(changeset)
  end

  defp validate_limit_value_length(true, changeset), do: changeset
  defp validate_limit_value_length(false, changeset) do
    changeset.changes.limit_value
    |> validate_limit_value_length(changeset.changes.limit_type, changeset)
  end

  defp validate_limit_value_length(0, _limit_type, changeset) do
    changeset
    |> Changeset.add_error(:limit_value, "must be greater than 0")
  end

  defp validate_limit_value_length(limit_value, "S", changeset) do
    "#{limit_value}"
    |> String.contains?(".")
    |> validate_limit_value_length(limit_value, "S", changeset)
  end

  defp validate_limit_value_length(false, limit_value, "S", changeset) do
    limit_value_length = String.length("#{limit_value}")

    if limit_value_length <= 6 do
      changeset
    else
      changeset
      |> Changeset.add_error(:limit_value, "up to 6 numeric characters only without decimal numbers")
    end
  end

  defp validate_limit_value_length(true, limit_value, "S", changeset) do
    limit_value_length = String.length("#{limit_value}")

    if limit_value_length <= 9 do
      changeset
    else
      changeset
      |> Changeset.add_error(:limit_value, "up to 8 numeric characters only with decimal numbers")
    end
  end

  defp validate_limit_value_length(limit_value, "PS", changeset) do
    limit_value_length =
      "#{limit_value}"
      |> String.replace(".", "")
      |> String.length()

    if limit_value_length <= 2 do
      changeset
    else
      changeset
      |> Changeset.add_error(:limit_value, "must be 2 numeric characters")
    end
  end

  defp add_index_in_error(errors, index) do
    Enum.into(errors, [], fn({key, {message, opts}}) ->
      {"#{key} (row #{index})", {message, opts}}
    end)
  end

  def insert_benefit_acu({:error, changeset}), do: {:error, changeset}
  def insert_benefit_acu(%Benefit{} = benefit) do
    benefit
    |> Map.put(:inserted_by, "masteradmin")
    |> Map.put(:updated_by, "masteradmin")
    |> Map.put(:version, "1")
    |> Map.put(:type, "R")
    |> Repo.insert()
  end

  def insert_benefit_acu(changes) do
    changes =
      if changes.category == "P" do
        changes
        |> Map.take([:code, :name, :category])
        |> Map.put(:limit, [%{"coverage_codes" => ["A"]}])
      else
        changes
      end

    {:ok, benefit} =
      %Benefit{}
      |> Map.merge(changes)
      |> insert_benefit_acu()

    {benefit, changes.limit}
  end

  def insert_benefit_limit({:error, changeset}), do: {:error, changeset}
  def insert_benefit_limit({benefit, []}), do: Repo.preload(benefit, :benefit_limits)
  def insert_benefit_limit({benefit, [head | tails]}) do
    params =
      head
      |> Map.put("benefit_code", benefit.code)
      |> Map.put("coverage_codes", ["A"])

    %BenefitLimit{}
    |> BenefitLimit.changeset(params)
    |> Repo.insert()

    insert_benefit_limit({benefit, tails})
  end

  defp check_errors(changeset, key) do
    changeset.errors
    |> Enum.into(%{}, &(&1))
    |> Map.has_key?(key)
  end
end
