defmodule Data.Schemas.Procedure do
  use Data.Schema
  @moduledoc false

  @primary_key {:code, :string, []}
  schema "procedures" do
    field :desc, :string
    field :type, :string
    field :standard, :string
    field :rate_type, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :code,
      :desc,
      :type,
      :standard,
      :rate_type
    ])
    |> validate_required([
      :code
    ])
  end
end
