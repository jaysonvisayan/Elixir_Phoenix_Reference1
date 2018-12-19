defmodule Data.Schemas.PreExistingConditionCondition do
  @moduledoc false

  use Data.Schema

  @foreign_key_type :string
  schema "pre_existing_condition_conditions" do
    field :member_type, :string
    field :disease_category, :string
    field :duration, :integer
    field :inner_limit_type, :string
    field :inner_limit_value, :string
    field :is_same_coverage_period_as_account, :boolean

    belongs_to :pre_existing_condition, Data.Schemas.PreExistingCondition, foreign_key: :pre_existing_condition_code

    timestamps()
  end

  def changeset(:create, struct, params) do
    struct
    |> cast(params, [
      :pre_existing_condition_code,
      :member_type,
      :disease_category,
      :duration,
      :inner_limit_type,
      :inner_limit_value,
      :is_same_coverage_period_as_account
    ])
  end

end
