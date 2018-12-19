defmodule Data.Repo.Migrations.CreatePlanCoverageRiskShareFacilities do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:plan_coverage_risk_share_facilities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plan_coverage_id, references(:plan_coverages, type: :binary_id)
      add :facility_code, references(:facilities, column: :code, type: :string, on_delete: :delete_all)
      add :risk_share_type, :string
      add :risk_share_value, :decimal
      add :rs_member_pays_handling, {:array, :string}

      timestamps()
    end
  end

  def down do
    drop table(:plan_coverage_risk_share_facilities)
  end
end
