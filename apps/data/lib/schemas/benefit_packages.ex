defmodule Data.Schemas.BenefitPackage do
  @moduledoc false
  use Data.Schema

  alias __MODULE__

  @primary_key {:code, :string, []}
  schema "benefit_packages" do
    field :name, :string

    timestamps()
  end

  def changeset(%BenefitPackage{} = struct, params \\ %{}) do
    struct
    |> cast(
      params,
      [
        :code,
        :name
      ])
    |> validate_required(
      [
        :code,
        :name
      ]
    )
 end
end
