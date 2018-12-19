defmodule Data.Schemas.Clinic do
  @moduledoc false
  use Data.Schema

  alias __MODULE__

  schema "clinics" do
    field :code, :string
    field :name, :string
    field :description, :string

    timestamps()
  end

  def changeset(%Clinic{} = struct, params \\ %{}) do
    struct
    |> cast(
      params,
      [
        :code,
        :name,
        :description
      ]
    )
    |> validate_required(
      [
        :code,
        :name
      ]
    )
  end


end
