defmodule Data.Schemas.Diagnosis do
  @moduledoc false

  use Data.Schema

  @primary_key {:code, :string, []}
  schema "diagnoses" do
    field :desc, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :code,
      :desc
    ])
    |> validate_required([
      :code
    ])
  end
end
