defmodule Data.Schemas.Exclusion do
  @moduledoc false

  alias Ecto.Changeset

  use Data.Schema

  @primary_key {:code, :string, []}
  schema "exclusions" do
    field :name, :string
    field :type, :string
    field :classification, :string
    field :diagnoses, {:array, :string}
    field :procedures, {:array, :string}
    field :policies, {:array, :string}
    field :status, :string
    field :version, :string
    field :inserted_by, :string
    field :updated_by, :string

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :code,
      :name,
      :type,
      :classification,
      :diagnoses,
      :procedures,
      :policies,
      :status,
      :version,
      :inserted_by,
      :updated_by,
    ])
  end
end

