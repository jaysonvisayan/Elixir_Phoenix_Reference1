defmodule Data.Schemas.Facility do
  use Data.Schema

  @moduledoc false

  @primary_key {:code, :string, []}
  schema "facilities" do
    field :name, :string
    field :type, :string

    has_many :plan_coverage_risk_share_facilities, Data.Schemas.PlanCoverageRiskShareFacilities, on_delete: :delete_all

    timestamps()
  end

  def changeset(struct, params \\  %{}) do
    struct
    |> cast(params, [
        :code,
        :name,
        :type
    ])
  end
end
