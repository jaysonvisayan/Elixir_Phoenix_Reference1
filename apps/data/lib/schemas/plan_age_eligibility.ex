defmodule Data.Schemas.PlanAgeEligibility do
  use Data.Schema

  @moduledoc false

  @foreign_key_type :string
  schema "plan_age_eligibilities" do
    field :member_type, :string
    field :min_age, :integer
    field :max_age, :integer

    belongs_to :plans, Data.Schemas.Plan, foreign_key: :plan_code

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :plan_code,
        :member_type,
        :min_age,
        :max_age,
    ])
  end
end
