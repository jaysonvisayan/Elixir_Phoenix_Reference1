defmodule Data.Contexts.ExclusionContext do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query

  alias Data.{
    Repo,
    Schemas.Diagnosis,
    Schemas.Exclusion,
    Schemas.Procedure
  }

  def validate_params(:search, params) do
    fields = %{
      page_number: :integer,
      search_value: :string,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:page_number, :display_per_page, :sort_by, :order_by], message: "is required")
    |> Changeset.validate_number(:page_number, greater_than: 0, message: "can't accept zero (0)")
    |> Changeset.validate_number(:display_per_page, greater_than: 0, message: "can't accept zero (0)")
    |> Changeset.validate_inclusion(:order_by, ["asc", "desc", "ASC", "DESC" ], message: "is invalid")
    |> Changeset.validate_inclusion(:sort_by, ["code", "name", "type", "updated_at", "version" ], message: "is invalid")
    |> is_valid_changeset?()
  end

  def validate_params(:view, params) do
    fields = %{
      code: :string,
      diagnosis: :map,
      procedure: :map
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:code, :diagnosis, :procedure], message: "is required")
    |> validate_preload(:diagnosis, params)
    |> validate_preload(:procedure, params)
    |> is_valid_changeset_view?(params)
  end

  def get_exclusions({:error, changeset}, :search), do: {:error, changeset}
  def get_exclusions({nil, _}, :search), do: nil
  def get_exclusions(params, :search) do
    search_value = if Map.has_key?(params, :search_value), do: params.search_value, else: ""
    offset = (params.page_number * params.display_per_page) - params.display_per_page

    Exclusion
    |> where([e],
             ilike(e.code, ^"%#{search_value}%") or
             ilike(e.name, ^"%#{search_value}%") or
             ilike(e.type, ^"%#{search_value}%") or
             ilike(fragment("to_char(?, 'MON DD, YYYY')", e.updated_at), ^("%#{search_value}%")) or
             ilike(e.version, ^"%#{search_value}%")
    )
    |> select([e], %{
      code: e.code,
      name: e.name,
      type: e.type,
      updated_at: fragment("to_char(?, 'MON DD, YYYY')", e.updated_at),
      version: e.version
    })
    |> order_datatable(
      params.sort_by,
      params.order_by
    )
    |> offset(^offset)
    |> limit(^params.display_per_page)
    |> Repo.all()
  end

  defp validate_preload(changeset, key, params) do
    if Map.has_key?(changeset.changes, key) do
      case Atom.to_string(key) do
        "diagnosis" ->
          changeset
          |> validate_preload_params(params, "diagnosis")
        "procedure" ->
          changeset
          |> validate_preload_params(params, "procedure")
        _ ->
          changeset
      end
    else
      changeset
    end
  end

  defp validate_preload_params(changeset, params, key) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    dc =
      {%{}, fields}
      |> Changeset.cast(params[key], Map.keys(fields))
      |> Changeset.validate_required([
        :page_number,
        :display_per_page,
        :sort_by,
        :order_by
      ], message: "is required")

    if dc.valid? do
      changeset
    else
      e = changeset.errors ++ transform_errors(dc.errors, key)

      changeset
      |> Map.put(:errors, e)
      |> Map.put(:valid?, false)
    end
  end

  defp transform_errors(errors, name) do
    errors
    |> Enum.into([], fn({key, {message, opts}}) ->
      {"#{key} (#{name})", {"#{message}", opts}}
    end)
  end

  def get_exclusion({:error, changeset}, :view), do: {:error, changeset}
  def get_exclusion({nil, _}, :view), do: nil
  def get_exclusion({_map, changeset}, :view) do
    changeset =
      changeset.changes
      |> get_by()
      |> preload_exclusion()
      |> get_exclusion_diagnoses(changeset)
      |> get_exclusion_procedures()
      |> is_valid_changeset_result?()
  end

  defp get_exclusion_diagnoses(nil, changeset), do: {nil, changeset}
  defp get_exclusion_diagnoses(exclusion, changeset) do
    params = changeset.changes
    search_value = if Map.has_key?(params, :diagnosis), do: params.diagnosis["search_value"], else: ""
    offset =
      (
        params.diagnosis["page_number"] * params.diagnosis["display_per_page"]
      ) - params.diagnosis["display_per_page"]
    codes = Enum.map(exclusion.diagnoses, &(&1.code))

    diagnosis =
      Diagnosis
      |> where([d], d.code in ^codes)
      |> where([d],
               ilike(fragment("lower(?)", d.code), ^"%#{search_value}%") or
               ilike(d.desc,  ^"%#{search_value}%")
      )
      |> select([d], %{
        code: d.code,
        description: d.desc
      })
      |> order_datatable_preload(
        params.diagnosis["sort_by"],
        params.diagnosis["order_by"]
      )
      |> offset(^offset)
      |> limit(^params.diagnosis["display_per_page"])
      |> Repo.all()

    if Enum.empty?(diagnosis) do
      {exclusion, changeset |> Changeset.add_error(:diagnosis, "#{search_value} not found")}
    else
      {exclusion |> Map.put(:diagnoses, diagnosis), changeset}
    end
  end

  defp get_exclusion_procedures({nil, changeset}), do: {nil, changeset}
  defp get_exclusion_procedures({exclusion, changeset}) do
    params = changeset.changes
    search_value = if Map.has_key?(params, :procedure), do: params.procedure["search_value"], else: ""
    offset =
      (
        params.procedure["page_number"] * params.procedure["display_per_page"]
      ) - params.procedure["display_per_page"]
    codes = Enum.map(exclusion.procedures, &(&1.code))

    procedure =
      Procedure
      |> where([p], p.code in ^codes)
      |> where([p],
               ilike(fragment("lower(?)", p.code), ^"%#{search_value}%") or
               ilike(p.desc,  ^"%#{search_value}%")
      )
      |> select([p], %{
        code: p.code,
        description: p.desc
      })
      |> order_datatable_preload(
        params.procedure["sort_by"],
        params.procedure["order_by"]
      )
      |> offset(^offset)
      |> limit(^params.procedure["display_per_page"])
      |> Repo.all()

    if Enum.empty?(procedure) do
      {exclusion, changeset |> Changeset.add_error(:procedure, "#{search_value} not found")}
    else
      {exclusion |> Map.put(:procedures, procedure), changeset}
    end
  end

  defp preload_exclusion(nil), do: nil
  defp preload_exclusion(exclusion) do
    exclusion
    |> Map.put(:diagnoses, get_diagnoses(exclusion))
    |> Map.put(:procedures, get_procedures(exclusion))
  end

  # Ascending
  defp order_datatable_preload(query, nil, nil), do: query
  defp order_datatable_preload(query, "", ""), do: query
  defp order_datatable_preload(query, "code", "asc"), do: query |> order_by([d], asc: d.code)
  defp order_datatable_preload(query, "description", "asc"), do: query |> order_by([d], asc: d.desc)

  # Descending
  defp order_datatable_preload(query, nil, nil), do: query
  defp order_datatable_preload(query, "", ""), do: query
  defp order_datatable_preload(query, "code", "desc"), do: query |> order_by([d], desc: d.code)
  defp order_datatable_preload(query, "description", "desc"), do: query |> order_by([d], desc: d.desc)

  defp transform_changeset(key) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }
    {%{}, fields}
    |> Changeset.cast(key, Map.keys(fields))
    |> Changeset.validate_required([:page_number, :display_per_page, :sort_by, :order_by], message: "is required")
    |> Changeset.validate_number(:page_number, greater_than: 0, message: "can't accept zero (0)")
    |> Changeset.validate_number(:display_per_page, greater_than: 0, message: "can't accept zero (0)")
    |> Changeset.validate_inclusion(:order_by, ["asc", "desc", "ASC", "DESC" ], message: "is invalid")
    |> Changeset.validate_inclusion(:sort_by, ["code", "desc"], message: "is invalid")
    |> is_valid_changeset?()
  end

  def validate_params(:create, params) do
    fields = %{
      code: :string,
      name: :string,
      type: :string,
      classification: :string,
      diagnoses: {:array, :string},
      procedures: {:array, :string},
      policies: {:array, :string}
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([
      :code,
      :name,
      :type,
      :classification
    ], message: "is required")
    |> validate_code()
    |> Changeset.validate_length(:code, max: 50, message: "must be up to 50 characters only")
    |> Changeset.validate_length(:name, max: 80, message: "must be up to 80 characters only")
    |> Changeset.validate_format(:code, ~r/^[ a-zA-Z0-9-_.]*$/, message: "only accepts special characters hyphen (-), underscore (_) and dot (.)")
    |> lower_value(:type)
    |> lower_value(:diagnoses)
    |> lower_value(:procedures)
    |> lower_value(:classification)
    |> Changeset.validate_inclusion(:type, ["icd/cpt based", "policy"], message: "select exclusion type")
    |> Changeset.validate_inclusion(:classification, ["standard", "custom"], message: "select classification type")
    |> validate_type(:type, params)
    |> return_value(:type, params)
    |> return_value(:classification, params)
    |> is_valid_changeset?()
  end

  def insert_exclusion({:error, changeset}), do: {:error, changeset}
  def insert_exclusion(params) do
    {:ok, exclusion} =
      %Exclusion{}
      |> Map.merge(params)
      |> Map.put(:inserted_by, "Masteradmin")
      |> Map.put(:updated_by, "Masteradmin")
      |> Map.put(:version, "1")
      |> Repo.insert()

    exclusion
    |> Map.put(:diagnoses, get_diagnoses(exclusion))
    |> Map.put(:procedures, get_procedures(exclusion))
  end

  defp validate_code(%{changes: %{code: _code}} = changeset) do
    validate_used_code(get_by(changeset.changes), changeset)
  end
  defp validate_code(changeset), do: changeset

  def is_valid_changeset?(changeset), do: {changeset.valid?, changeset}
  def is_valid_changeset_view?(changeset, map), do: {changeset.valid?, {map, changeset}}

  def is_valid_changeset_result?({nil, _changeset}), do: nil
  def is_valid_changeset_result?({exclusion, changeset}) do
    if changeset.valid? do
      exclusion
    else
      {:error, changeset}
    end
  end

  defp validate_used_code(nil, changeset), do: changeset
  defp validate_used_code(_code, changeset), do: Changeset.add_error(changeset, :code, "is already taken")

  defp lower_value(changeset, :diagnoses) do
    with true <- Map.has_key?(changeset.changes, :diagnoses) do
      string =
        changeset.changes[:diagnoses]
        |> Enum.map(&(String.downcase(&1)))
      changeset
      |> Changeset.put_change(:diagnoses, string)
    else
      _ ->
        changeset
    end
  end

  defp lower_value(changeset, :procedures) do
    with true <- Map.has_key?(changeset.changes, :procedures) do
      string =
        changeset.changes[:procedures]
        |> Enum.map(&(String.downcase(&1)))
      changeset
      |> Changeset.put_change(:procedures, string)
    else
      _ ->
        changeset
    end
  end

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

  defp return_value(changeset, :diagnoses, params) do
    params =
      params
      |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
    with true <- Map.has_key?(changeset.changes, :diagnoses) do
      changeset
      |> Changeset.put_change(:diagnoses, params[:diagnoses])
    else
      _ ->
        changeset
    end
  end

  defp return_value(changeset, :procedures, params) do
    params =
      params
      |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
    with true <- Map.has_key?(changeset.changes, :procedures) do
      changeset
      |> Changeset.put_change(:procedures, params[:procedures])
    else
      _ ->
        changeset
    end
  end

  defp return_value(changeset, key, params) do
    params =
      params
      |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
    with true <- Map.has_key?(changeset.changes, key) do
      changeset
      |> Changeset.put_change(key, params[key])
    else
      _ ->
        changeset
    end
  end


  defp validate_type(changeset, key, params) do
    changeset |> validate_exclusion_type(changeset.changes[key], params)
  end

  defp validate_exclusion_type(changeset, "policy", _), do: changeset |> validate_policies()
  defp validate_exclusion_type(changeset, "icd/cpt based", params) do
    changeset
    |> validate_empty_codes()
    |> validate_diagnosis_codes()
    |> validate_procedure_codes()
    |> remove_policies()
    |> return_value(:diagnoses, params)
    |> return_value(:procedures, params)
  end
  defp validate_exclusion_type(changeset, _, _), do: changeset

  defp validate_empty_codes(changeset) do
    with true <- Enum.any?([
                          Map.has_key?(changeset.changes, :diagnoses),
                          Map.has_key?(changeset.changes, :procedures)
                        ])
    do
      changeset
    else
      _ ->
        Changeset.add_error(changeset, :type, "Add at least one diagnosis or procedure")
    end
  end

  defp validate_invalid_codes(changeset, :diagnosis) do
    {_, diagnoses} =
      if Map.has_key?(changeset.changes, :diagnoses) do
        filter_empty_strings(changeset.changes.diagnoses)
      else
        {nil, []}
      end
    {_, procedures} =
      if Map.has_key?(changeset.changes, :procedures) do
        filter_empty_strings(changeset.changes.procedures)
      else
        {nil, []}
      end
    cond do
      Enum.all?([Enum.empty?(diagnoses), Enum.empty?(procedures)]) ->
        {false, :empty_all}
      Enum.all?([Enum.empty?(procedures), !Enum.empty?(diagnoses)]) ->
        {true, :diagnoses}
      Enum.all?([!Enum.empty?(procedures), Enum.empty?(diagnoses)]) ->
        {false, :empty_diagnoses}
      true ->
        {true, :diagnoses}
    end
  end

  defp validate_invalid_codes(changeset, :procedures) do
    {_, diagnoses} =
      if Map.has_key?(changeset.changes, :diagnoses) do
        filter_empty_strings(changeset.changes.diagnoses)
      else
        {nil, []}
      end
    {_, procedures} =
      if Map.has_key?(changeset.changes, :procedures) do
        filter_empty_strings(changeset.changes.procedures)
      else
        {nil, []}
      end
    cond do
      Enum.all?([Enum.empty?(diagnoses), Enum.empty?(procedures)]) ->
        {false, :empty_all}
      Enum.all?([!Enum.empty?(procedures), Enum.empty?(diagnoses)]) ->
        {true, :procedures}
      Enum.all?([Enum.empty?(procedures), !Enum.empty?(diagnoses)]) ->
        {false, :empty_procedures}
      true ->
        {true, :procedures}
    end
  end

  defp validate_diagnosis_codes(%{changes: %{diagnoses: []}} = changeset) do
    with true <- Map.has_key?(changeset.changes, :procedures),
         false <- Enum.empty?(changeset.changes.procedures),
         {true, _updated_list} <- filter_empty_strings(changeset.changes.procedures)
    do
      changeset
    else
      _ ->
        Changeset.add_error(changeset, :type, "Add at least one diagnosis or procedure")
    end
  end

  defp validate_diagnosis_codes(%{changes: %{diagnoses: diagnoses}} = changeset) do
    with {true, :diagnoses} <- validate_invalid_codes(changeset, :diagnosis),
         {true, _} <- filter_empty_strings(changeset.changes.diagnoses)
    do
      result = check_diagnosis_codes(changeset.changes.diagnoses)
      invalid_codes = Enum.uniq(diagnoses) -- result
      if Enum.empty?(invalid_codes) do
        changeset
      else
        errors = Enum.join(invalid_codes, ", ")
        Changeset.add_error(changeset, :diagnoses, "#{errors} does not exist")
      end
    else
      {false, :empty_all} ->
        Changeset.add_error(changeset, :type, "Add at least one diagnosis or procedure")
      {false, :empty_diagnoses} ->
        changeset
      _ ->
        changeset
    end
  end
  defp validate_diagnosis_codes(changeset), do: changeset

  defp validate_procedure_codes(%{changes: %{procedures: []}} = changeset) do
    with true <- Map.has_key?(changeset.changes, :diagnoses),
         false <- Enum.empty?(changeset.changes.diagnoses),
         {true, _updated_list} <- filter_empty_strings(changeset.changes.diagnoses)
    do
      changeset
    else
      _ ->
        Changeset.add_error(changeset, :type, "Add at least one diagnosis or procedure")
    end
  end
  defp validate_procedure_codes(%{changes: %{procedures: procedures}} = changeset) do
    with {true, :procedures} <- validate_invalid_codes(changeset, :procedures),
         {true, _} <- filter_empty_strings(changeset.changes.procedures)
    do
      result = check_procedure_codes(changeset.changes.procedures)
      invalid_codes = Enum.uniq(procedures) -- result
      if Enum.empty?(invalid_codes) do
        changeset
      else
        errors = Enum.join(invalid_codes, ", ")
        Changeset.add_error(changeset, :procedures, "#{errors} does not exist")
      end
    else
      {false, :empty_all} ->
        Changeset.add_error(changeset, :type, "Add at least one diagnosis or procedure")
      {false, :empty_procedures} ->
        changeset
      _ ->
        changeset
    end
  end
  defp validate_procedure_codes(changeset), do: changeset

  defp remove_procedures(changeset) do
    with true <- Map.has_key?(changeset.changes, :procedures),
         false <- Enum.empty?(changeset.changes.procedures)
    do
      Changeset.put_change(changeset, :procedures, [])
    else
      _ ->
        changeset
    end
  end

  defp remove_diagnoses(changeset) do
    with true <- Map.has_key?(changeset.changes, :diagnoses),
         false <- Enum.empty?(changeset.changes.diagnoses)
    do
      Changeset.put_change(changeset, :diagnoses, [])
    else
      _ ->
        changeset
    end
  end

  defp remove_policies(changeset) do
    with true <- Map.has_key?(changeset.changes, :policies),
         false <- Enum.empty?(changeset.changes.policies)
    do
      Changeset.put_change(changeset, :policies, [])
    else
      _ ->
        changeset
    end
  end

  defp validate_policies(changeset) do
    with true <- Map.has_key?(changeset.changes, :policies),
         {true, updated_list} <- filter_empty_strings(changeset.changes.policies)
    do
      changeset
      |> Changeset.put_change(:policies, updated_list)
      |> remove_procedures()
      |> remove_diagnoses()
    else
      _ ->
        Changeset.add_error(changeset, :type, "Add at least one policy")
    end
  end

  defp filter_empty_strings(list) do
    empty_strings = list |> Enum.filter(&(&1 == ""))
    updated_list = list -- empty_strings

    {!Enum.empty?(updated_list), updated_list}
  end
  defp filter_empty_strings([]), do: {false, []}

  defp check_diagnosis_codes(codes) do
    codes = codes |> Enum.map(&(String.downcase(&1)))
    Diagnosis
    |> where([d], fragment("lower(?)", d.code) in ^codes)
    |> select([d], fragment("lower(?)", d.code))
    |> Repo.all()
  end

  defp check_procedure_codes(codes) do
    codes = codes |> Enum.map(&(String.downcase(&1)))
    Procedure
    |> where([p], fragment("lower(?)", p.code) in ^codes)
    |> select([p], fragment("lower(?)", p.code))
    |> Repo.all()
  end

  # Ascending
  defp order_datatable(query, nil, nil), do: query
  defp order_datatable(query, "", ""), do: query
  defp order_datatable(query, "code", "asc"), do: query |> order_by([e], asc: e.code)
  defp order_datatable(query, "name", "asc"), do: query |> order_by([e], asc: e.name)
  defp order_datatable(query, "type", "asc"), do: query |> order_by([e], asc: e.type)
  defp order_datatable(query, "updated_at", "asc"), do: query |> order_by([e], asc: e.updated_at)
  defp order_datatable(query, "version", "asc"), do: query |> order_by([e], asc: e.version)

  # Descending
  defp order_datatable(query, "code", "desc"), do: query |> order_by([e], desc: e.code)
  defp order_datatable(query, "name", "desc"), do: query |> order_by([e], desc: e.name)
  defp order_datatable(query, "type", "desc"), do: query |> order_by([e], desc: e.type)
  defp order_datatable(query, "updated_at", "desc"), do: query |> order_by([e], desc: e.updated_at)
  defp order_datatable(query, "version", "desc"), do: query |> order_by([e], desc: e.version)

  def insert_exclusion_seed(params) do
    params
    |> get_by()
    |> create_update_exclusion(params)
  end

  defp create_update_exclusion(nil, params) do
    %Exclusion{}
    |> Exclusion.changeset(params)
    |> Repo.insert()
  end

  defp create_update_exclusion(exclusion, params) do
    exclusion
    |> Exclusion.changeset(params)
    |> Repo.update()
  end

  defp get_by(%{code: code} = _params) do
    Exclusion |> Repo.get_by(code: code)
  end

  defp get_diagnoses(%{diagnoses: codes}) when codes == [], do: []
  defp get_diagnoses(%{diagnoses: codes}) when is_nil(codes), do: []
  defp get_diagnoses(%{diagnoses: codes} = _codes) do
    codes = codes |> Enum.map(&(String.downcase(&1)))
    Diagnosis
    |> where([d], fragment("lower(?)", d.code) in ^codes)
    |> select([d], %{code: d.code, description: d.desc})
    |> Repo.all()
  end

  defp get_procedures(%{procedures: codes}) when codes == [], do: []
  defp get_procedures(%{procedures: codes}) when is_nil(codes), do: []
  defp get_procedures(%{procedures: codes} = _codes) do
    codes = codes |> Enum.map(&(String.downcase(&1)))
    Procedure
    |> where([p], fragment("lower(?)", p.code) in ^codes)
    |> select([p], %{code: p.code, description: p.desc})
    |> Repo.all()
  end
end
