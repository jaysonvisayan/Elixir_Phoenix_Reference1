defmodule Data.Contexts.ProcedureContext do
  @moduledoc false

  alias Data.Schemas.Procedure, as: PS
  alias Data.Repo
  alias Ecto.Changeset, warn: false

  import Ecto.Query

  # For Seed
  #
  def insert_procedure_seed(params) do
    params
    |> get_by()
    |> create_update_procedure(params)
  end

  defp create_update_procedure(nil, params) do
    %PS{}
    |> PS.changeset(params)
    |> Repo.insert()
  end

  defp create_update_procedure(procedure, params) do
    procedure
    |> PS.changeset(params)
    |> Repo.update()
  end

  defp get_by(params) do
    PS |> Repo.get_by(params)
  end

end
