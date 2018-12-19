defmodule Data.Contexts.PreExistingConditionContext do

  @moduledoc false
  alias Data.{
    Contexts.UtilityContext,
    Repo,
    Schemas.Diagnosis,
    Schemas.PreExistingCondition,
    Schemas.PreExistingConditionDiagnosis,
    Schemas.PreExistingConditionCondition,
  }
  alias Ecto.Changeset, warn: false
  import Ecto.Query

  def validate_params(:view, params) do
    fields = %{
      code: :string
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:code], message: "entered is invalid")
    |> is_valid_changeset?()
  end

  def validate_params(:create, params) do
    fields = %{
      code: :string,
      name: :string,
      diagnosis: {:array, :string},
      conditions: {:array, :map}
    }
    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([
      :code,
      :name,
      :diagnosis
    ])
    |> Changeset.validate_length(:code, max: 50, message: "must be at most 50 characters")
    |> Changeset.validate_length(:name, max: 80, message: "must be at most 80 characters")
    |> Changeset.validate_format(:code, ~r/^[ a-zA-Z0-9-_.]*$/)
    |> Changeset.validate_length(:diagnosis, min: 1, message: "at least one is required")
    |> Changeset.validate_length(:conditions, min: 1, message: "at least one is required")
    |> validate_code()
    |> validate_diagnosis_codes()
    |> validate_conditions()
    |> validate_condition_duplicates()
    # if changeset.valid? do
    #   {:ok, changeset}
    # else
    #   {:error, changeset}
    # end
  end

  defp validate_code(%{changes: %{code: code}} = changeset) do
    checker = get_by(%{code: code})
    if is_nil(checker) do
      changeset
    else
      Changeset.add_error(changeset, :code, "already exists")
    end
  end
  defp validate_code(changeset), do: changeset

  defp validate_diagnosis_codes(%{changes: %{diagnosis: diagnosis}} = changeset) do
    result = check_diagnosis_codes(changeset.changes.diagnosis)
    invalid_codes = Enum.uniq(diagnosis) -- result
    if Enum.empty?(invalid_codes) do
      changeset
    else
      errors = Enum.join(invalid_codes, ", ")
      Changeset.add_error(changeset, :diagnosis, "#{errors} does not exist")
    end
  end
  defp validate_diagnosis_codes(changeset), do: changeset

  defp check_diagnosis_codes(codes) do
    Diagnosis
    |> where([d], d.code in ^codes)
    |> select([d], d.code)
    |> Repo.all()
  end

  defp validate_condition_duplicates(%{changes: %{conditions: conditions}} = changeset) do
    unique = Enum.uniq(conditions)
    if Enum.empty?(conditions -- unique) do
      changeset
    else
      Changeset.add_error(changeset, :conditions, "conditions cannot have duplicates")
    end
  end
  defp validate_condition_duplicates(changeset), do: changeset

  defp validate_conditions(%{changes: %{conditions: conditions}} = changeset) do
    errors =
      conditions
      |> Enum.with_index(1)
      |> validate_condition_params([])
    if Enum.empty?(errors) do
      changeset
    else
      Changeset.add_error(changeset, :conditions, Enum.join(errors, ", "))
    end
  end
  defp validate_conditions(changeset), do: changeset

  defp validate_condition_params([{params, index} | tails], errors) do
    fields = %{
      is_same_coverage_period_as_account: :boolean,
      member_type: :string,
      disease_category: :string,
      duration: :integer,
      inner_limit_type: :string,
      inner_limit_value: :string
    }
    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :is_same_coverage_period_as_account,
        :member_type,
        :disease_category,
        :duration,
        :inner_limit_type,
        :inner_limit_value
      ])
      # P = PRINCIPAL, D = DEPENDENT
      |> Changeset.validate_inclusion(:member_type, ["P", "D"], message: "is invalid")
      # P = PESO, PC = PERCENTAGE, S = SESSION
      |> Changeset.validate_inclusion(:inner_limit_type, ["PS", "PC", "S"], message: "is invalid")
      # D = DREADED, ND = NON-DREADED
      |> Changeset.validate_inclusion(:disease_category, ["D", "ND"], message: "please choose from D or ND")
      |> Changeset.validate_number(:duration, less_than_or_equal_to: 9999, message: "cannot exceed 9999")
      |> validate_limit_amount()
    if changeset.valid? do
      validate_condition_params(tails, errors)
    else
      error_message = UtilityContext.changeset_errors_to_string(changeset.errors)
      errors = errors ++ ["row #{index} errors (#{error_message})"]
      validate_condition_params(tails, errors)
    end
  end
  defp validate_condition_params([], errors), do: errors

  defp generate_string_list(value), do: for x <- value, do: Integer.to_string(x)

  defp validate_limit_amount(%{
    changes: %{
      inner_limit_type: "PC",
      inner_limit_value: limit_amount
    }
  } = changeset) do
    if Enum.member?(generate_string_list(1..100), limit_amount) do
      changeset
    else
      Changeset.add_error(changeset, :inner_limit_value, "should be 1-100")
    end
  end

  defp validate_limit_amount(%{
    changes: %{
      inner_limit_type: "PS",
      inner_limit_value: _limit_amount
    }
  } = changeset) do
    Changeset.validate_format(changeset, :inner_limit_value, ~r/^[0-9]*(\.[0-9]{1,90})?$/, message: "is invalid")
  end

  defp validate_limit_amount(%{
    changes: %{
      inner_limit_type: "S",
      inner_limit_value: limit_amount
    }
  } = changeset) do
    if Enum.member?(generate_string_list(1..999), limit_amount) do
      changeset
    else
      Changeset.add_error(changeset, :inner_limit_value, "is invalid")
    end
  end

  defp validate_limit_amount(changeset), do: changeset

  def get_by(params) do
    PreExistingCondition
    |> Repo.get_by(params)
  end

  def insert_pre_existing_condition(%{valid?: true} = changeset, params) do
    params =
      params
      |> Map.put("diagnoses", params["diagnosis"] || [])
      |> Map.put("conditions", params["conditions"] || [])
    :create
    |> PreExistingCondition.changeset(%PreExistingCondition{}, params)
    |> Repo.insert()
  end
  def insert_pre_existing_condition(changeset, _params), do: {:error, changeset}

  def insert_pec_diagnoses(
    {
      %{
        valid?: true,
        changes: %{
          diagnosis: diagnosis
        }
      } = changeset, pec
    }
  ) do
    diagnoses = insert_pec_diagnosis(diagnosis, pec.code, [])
    {changeset, Map.put(pec, :diagnosis, diagnoses)}
  end
  def insert_pec_diagnoses({:error, changeset}), do: {:error, changeset}

  def insert_pec_diagnosis([diagnosis_code | tails], pec_code, results) do
    result =
      :create
      |> PreExistingConditionDiagnosis.changeset(
        %PreExistingConditionDiagnosis{},
        %{
          pre_existing_condition_code: pec_code,
          diagnosis_code: diagnosis_code
        }
      )
      |> Repo.insert!()
      |> load_diagnosis()
    insert_pec_diagnosis(tails, pec_code, results ++ [result])
  end
  def insert_pec_diagnosis([], _pec_code, results), do: results

  def load_diagnosis(pec_diagnosis) do
    pec_diagnosis
    |> Map.put(:diagnosis, get_diagnosis_by_code(pec_diagnosis))
  end

  defp get_diagnosis_by_code(pec_diagnosis) do
    Diagnosis
    |> select([d], %{code: d.code, desc: d.desc})
    |> where([d], d.code == ^pec_diagnosis.diagnosis_code)
    |> limit(1)
    |> Repo.one()
  end

  def insert_pec_conditions(
    {
      %{
        valid?: true,
        changes: %{
          conditions: conditions
        }
      },
      pec
    }
  ) do
    conditions = insert_pec_condition(conditions, pec.code, [])
    Map.put(pec, :conditions, conditions)
  end
  def insert_pec_conditions({:error, changeset}), do: {:error, changeset}

  # def insert_pec_conditions(pec_code, %{changes: %{conditions: conditions}}) do
  #   {:ok, insert_pec_condition(conditions, pec_code, [])}
  # end
  # def insert_pec_conditions(_pec_code, _changeset_), do: {:ok, []}

  def insert_pec_condition([params | tails], pec_code, results) do
    result =
      :create
      |> PreExistingConditionCondition.changeset(
        %PreExistingConditionCondition{},
        %{
          pre_existing_condition_code: pec_code,
          member_type: params["member_type"],
          disease_category: params["disease_category"],
          duration: params["duration"],
          inner_limit_type: params["inner_limit_type"],
          inner_limit_value: params["inner_limit_value"],
          is_same_coverage_period_as_account: params["is_same_coverage_period_as_account"]
        }
      )
      |> Repo.insert!()
    insert_pec_condition(tails, pec_code, results ++ [result])
  end
  def insert_pec_condition([], _pec_code, results), do: results

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
      |> Changeset.validate_number(:page_number, greater_than: 0)
      |> Changeset.validate_number(:display_per_page, greater_than: 0)
      |> Changeset.validate_inclusion(:sort_by, [
        "code",
        "CODE",
        "category",
        "CATEGORY",
        "updated_at",
        "UPDATED_AT",
        "updated_by",
        "UPDATED_BY"
      ], message: "invalid parameters")
      |> Changeset.validate_inclusion(:order_by, [
        "asc",
        "desc",
        "ASC",
        "DESC"
      ], message: "invalid parameters")
      |> validate_key_search(params["search_value"])
      |> is_valid_changeset?()
  end

  defp convert_params_to_atom(params), do: Map.new(params, fn {key, value} -> {String.to_atom(key), value} end)
  defp is_valid_changeset?(changeset), do: {changeset.valid?, changeset}

  def get_pre_existing_conditions({:error, changeset}, _), do: {:error, changeset}
  def get_pre_existing_conditions(params, :search) do
    search_value = if Map.has_key?(params, :search_value), do: params.search_value, else: ""
    offset = (params.page_number * params.display_per_page) - params.display_per_page

    PreExistingCondition
    |> where([pec],
      ilike(pec.code, ^"%#{search_value}%") or
      ilike(pec.name, ^"%#{search_value}%") or
      ilike(pec.category, ^"%#{search_value}%") or
      ilike(pec.updated_by, ^"%#{search_value}%")
      )
    |> select([pec],
      %{
        code: pec.code,
        name: pec.name,
        category: pec.category,
        updated_at: fragment("to_char(?, 'MM/DD/YYYY')", pec.updated_at),
        updated_by: pec.updated_by
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

  defp order_datatable(query, nil, nil), do: query
  defp order_datatable(query, "", ""), do: query
  defp order_datatable(query, sort_by, order_by) do
    if String.downcase(order_by) == "asc" do
      sort_datatable_asc(query, String.downcase(sort_by))
    else
      sort_datatable_desc(query, String.downcase(sort_by))
    end
  end

  # ASCENDING
  defp sort_datatable_asc(query, sort_by) when sort_by == "code", do: query |> order_by([pec], asc: pec.code)
  defp sort_datatable_asc(query, sort_by) when sort_by == "name", do: query |> order_by([pec], asc: pec.name)
  defp sort_datatable_asc(query, sort_by) when sort_by == "category", do: query |> order_by([pec], asc: pec.category)
  defp sort_datatable_asc(query, sort_by) when sort_by == "updated_by", do: query |> order_by([pec], asc: pec.updated_by)
  defp sort_datatable_asc(query, sort_by) when sort_by == "", do: query

  # DESCENDING
  defp sort_datatable_desc(query, sort_by) when sort_by == "code", do: query |> order_by([pec], desc: pec.code)
  defp sort_datatable_desc(query, sort_by) when sort_by == "name", do: query |> order_by([pec], desc: pec.name)
  defp sort_datatable_desc(query, sort_by) when sort_by == "category", do: query |> order_by([pec], desc: pec.category)
  defp sort_datatable_desc(query, sort_by) when sort_by == "updated_by", do: query |> order_by([pec], desc: pec.updated_by)
  defp sort_datatable_desc(query, sort_by) when sort_by == "", do: query

  defp validate_key_search(changeset, ""), do: changeset |> Changeset.put_change(:search_value, "")
  defp validate_key_search(changeset, nil), do: changeset |> Changeset.add_error(:search_value, "is not in the parameters")
  defp validate_key_search(changeset, _params), do: changeset |> validate_search_value(changeset.changes)

  defp validate_search_value(changeset, changes) when map_size(changes) == 0 do
    changeset
    |> Changeset.add_error(:search_value, "is not in the parameters")
  end
  defp validate_search_value(changeset, _changes), do: changeset

  defp existing_pec?(params) when is_nil(params), do: {:error_message, "code entered is invalid"}
  defp existing_pec?(params), do: params

  defp case_insensitive(params) do
    PreExistingCondition
    |> where([m], fragment("LOWER(?)", m.code) == fragment("LOWER(?)", ^params.code))
    |> select([m], m)
    |> Repo.one()
  end

  def get_pre_existing_condition(%{code: code} = params) do
    params
    |> case_insensitive()
  end

  def get_pre_existing_condition(%{code: code} = params, :view) do
    params
    |> case_insensitive()
    |> existing_pec?()
  end

  def get_get_pre_existing_condition({:error, changeset}), do: {:error, changeset}

  def get_get_pre_existing_condition({:error, changeset}, :view), do: {:error, changeset}

end
