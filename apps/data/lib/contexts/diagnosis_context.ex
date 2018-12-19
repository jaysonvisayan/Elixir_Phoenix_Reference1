defmodule Data.Contexts.DiagnosisContext do
  @moduledoc false

  alias Data.Schemas.Diagnosis, as: DS
  alias Data.Repo
  alias Ecto.Changeset, warn: false

  import Ecto.Query

  # For Seed
  #
  def insert_diagnosis_seed(params) do
    params
    |> get_by()
    |> create_update_diagnosis(params)
  end

  defp create_update_diagnosis(nil, params) do
    %DS{}
    |> DS.changeset(params)
    |> Repo.insert()
  end

  defp create_update_diagnosis(diagnosis, params) do
    diagnosis
    |> DS.changeset(params)
    |> Repo.update()
  end

  defp get_by(params) do
    DS |> Repo.get_by(params)
  end

end
