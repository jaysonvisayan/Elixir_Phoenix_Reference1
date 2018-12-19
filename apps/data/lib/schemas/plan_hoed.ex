defmodule Data.Schemas.PlanHoed do
  use Data.Schema
  @moduledoc false


  @foreign_key_type :string
  schema "plan_hoed" do
    field :civil_status, {:array, :string}
    field :dependent_hierarchy, {:array, :string}

    belongs_to :plans, Data.Schemas.Plan, foreign_key: :plan_code

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :plan_code,
        :civil_status,
        :dependent_hierarchy
    ])
  end
end
