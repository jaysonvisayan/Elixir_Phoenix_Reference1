defmodule Data.Schemas.PlanLimit do
  use Data.Schema
  @moduledoc false

  @foreign_key_type :string
  schema "plan_limits" do
    field :coverage_code, {:array, :string}
    field :limit_type, :string
    field :limit_amount, :decimal
    field :extension_limit, :decimal

    belongs_to :plans, Data.Schemas.Plan, foreign_key: :plan_code

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :plan_code,
        :coverage_code,
        :limit_type,
        :limit_amount,
        :extension_limit
    ])
  end
end
