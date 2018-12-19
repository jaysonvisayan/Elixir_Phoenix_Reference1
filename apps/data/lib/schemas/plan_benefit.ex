defmodule Data.Schemas.PlanBenefit do
  use Data.Schema

  @moduledoc false

  @foreign_key_type :string
  schema "plan_benefits" do
    field :coverage_code, {:array, :string}
    field :limit_type, :string
    field :limit_value, :string


    belongs_to :plans, Data.Schemas.Plan, foreign_key: :plan_code
    belongs_to :benefits, Data.Schemas.Benefit, foreign_key: :benefit_code

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :plan_code,
        :benefit_code,
        :coverage_code,
        :limit_type,
        :limit_value
   ])
  end
end

