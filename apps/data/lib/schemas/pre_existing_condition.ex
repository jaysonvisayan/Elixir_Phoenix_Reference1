defmodule Data.Schemas.PreExistingCondition do
  use Data.Schema
  @moduledoc false

  @primary_key {:code, :string, []}
  schema "pre_existing_conditions" do
    field :name, :string
    field :category, :string
    field :updated_by, :string
    field :inserted_by, :string
    field :diagnoses, {:array, :string}
    field :conditions, {:array, :map}

    has_many :plan_pre_existing_conditions, Data.Schemas.PlanPreExistingCondition, on_delete: :delete_all

    timestamps()
  end

  def changeset(:create, struct, params) do
    struct
    |> cast(params, [
      :code,
      :name,
      :diagnoses,
      :conditions
    ])
  end

end
