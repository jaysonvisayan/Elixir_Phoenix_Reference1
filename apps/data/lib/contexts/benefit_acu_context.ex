defmodule Data.Contexts.BenefitAcuContext do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query

  alias Data.{
    Repo,
    Schemas.Benefit,
    Schemas.Package
  }

  def validate_params(:search, params) do
    fields = %{
      code: :string
    }

    {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([:code], message: "is required")
      |> is_valid_changeset?()
  end

  def is_valid_changeset?(changeset), do: {changeset.valid?, changeset}

  def get_benefit_acu({:error, changeset}, _), do: {:error, changeset}
  def get_benefit_acu(params, :search) do
    params
    |> get_by()
    |> get_packages()
  end


  defp get_packages(nil), do: []
  defp get_packages(struct) do
    test1 =
    get_struct_packages(struct.packages)

    struct
    |> Map.put(:packages, test1)

  end

  def get_struct_packages(nil), do: []
  def get_struct_packages(packages) do
    packages
    |> Enum.map(fn(package) ->
      Package
      |> Repo.get_by(code: package)
      |> get_name_and_code()
    end)
  end

  defp get_name_and_code(struct) do
    %{
      name: struct.name,
      code: struct.code
    }
  end

  defp get_by(params) do
    Benefit |> Repo.get_by(params)
  end
end
