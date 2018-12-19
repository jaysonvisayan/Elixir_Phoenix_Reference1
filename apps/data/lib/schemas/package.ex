defmodule Data.Schemas.Package do
  @moduledoc false
  use Data.Schema

  alias __MODULE__

  @primary_key {:code, :string, []}
  schema "packages" do
    field :name, :string

    timestamps()
  end

  def changeset(%Package{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:code, :name])
    |> validate_required([:code, :name])
  end
end
