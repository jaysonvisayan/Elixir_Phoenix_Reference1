defmodule Data.Contexts.PackageContext do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query

  alias Data.{
    Repo,
    Schemas.Package
  }

  # For Seed

  def insert_package_seed(params) do
    params
    |> package_get_by()
    |> create_update_package(params)
  end

  defp create_update_package(nil, params) do
    %Package{}
    |> Package.changeset(params)
    |> Repo.insert()
  end

  defp create_update_package(package, params) do
    package
    |> Package.changeset(params)
    |> Repo.update()
  end

  defp package_get_by(params) do
    Package |> Repo.get_by(params)
  end
end
