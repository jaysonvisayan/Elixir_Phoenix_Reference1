defmodule Data.Schemas.PlanCoverageRiskShareFacilities do
  use Data.Schema
  @moduledoc false


  @foreign_key_type :string
  schema "plan_coverage_risk_share_facilities" do
    field :risk_share_type, :string
    field :risk_share_value, :decimal
    field :rs_member_pays_handling, {:array, :string}

    belongs_to :plan_coverages, Data.Schemas.PlanCoverage, foreign_key: :plan_coverage_id
    belongs_to :facilities, Data.Schemas.Facility, foreign_key: :facility_code

    timestamps()
  end

  def changeset(struct, params \\  %{}) do
    struct
    |> cast(params, [
        :plan_coverage_id,
        :facility_code,
        :risk_share_type,
        :risk_share_value,
        :rs_member_pays_handling
    ])
  end
end
