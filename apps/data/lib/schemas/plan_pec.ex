defmodule Data.Schemas.PlanPreExistingCondition do
  use Data.Schema
  @moduledoc false


  @foreign_key_type :string
  schema "plan_pre_existing_conditions" do
    field :is_same_coverage_period_as_account, :boolean
    field :member_type, :string
    field :disease_category, :string
    field :duration, :integer
    field :inner_limit_type, :string
    field :inner_limit_value, :string

    belongs_to :plans, Data.Schemas.Plan, foreign_key: :plan_code
    belongs_to :pre_existing_conditions, Data.Schemas.PreExistingCondition, foreign_key: :pec_code

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :plan_code,
        :pec_code,
        :is_same_coverage_period_as_account,
        :member_type,
        :disease_category,
        :duration,
        :inner_limit_type,
        :inner_limit_value
    ])
  end
end
