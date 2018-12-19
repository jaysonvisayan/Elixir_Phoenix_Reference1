defmodule Data.Schemas.PlanCoverage do
  use Data.Schema
  @moduledoc false

  @foreign_key_type :string
  schema "plan_coverages" do
    field :coverage_code, :string
    field :funding_arrangement, :string
    field :member_pays_handling, {:array, :string}
    field :is_room_category, :boolean
    field :is_amount, :boolean
    field :amount_type, :string
    field :amount_value, :decimal
    field :is_days, :boolean
    field :days_type, :string
    field :days_value, :integer
    field :room_upgrade, :integer
    field :incremental_cost, :decimal
    field :is_facility_all_coverage, :boolean
    field :facility_type, :string
    field :facility_group_codes, {:array, :string}
    field :excluded_facility_codes, {:array, :string}
    field :specific_facility_codes, {:array, :string}
    field :is_risk_share_all_coverage, :boolean
    field :risk_share_all_type, :string
    field :risk_share_all_value, :decimal
    field :rs_member_pays_handling, {:array, :string}

    belongs_to :plans, Data.Schemas.Plan, foreign_key: :plan_code

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
        :plan_code,
        :coverage_code,
        :funding_arrangement,
        :member_pays_handling,
        :is_room_category,
        :is_amount,
        :amount_type,
        :amount_value,
        :is_days,
        :days_type,
        :days_value,
        :room_upgrade,
        :incremental_cost,
        :is_facility_all_coverage,
        :facility_type,
        :facility_group_codes,
        :excluded_facility_codes,
        :specific_facility_codes,
        :is_risk_share_all_coverage,
        :risk_share_all_type,
        :risk_share_all_value,
        :rs_member_pays_handling
    ])
  end
end
