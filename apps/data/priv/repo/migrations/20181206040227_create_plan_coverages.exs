defmodule Data.Repo.Migrations.CreatePlanCoverages do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:plan_coverages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plan_code, references(:plans, column: :code, type: :string, on_delete: :delete_all)
      add :coverage_code, :string
      add :funding_arrangement, :string
      add :member_pays_handling, {:array, :string}
      add :is_room_category, :boolean
      add :is_amount, :boolean
      add :amount_type, :string
      add :amount_value, :decimal
      add :is_days, :boolean
      add :days_type, :string
      add :days_value, :integer
      add :room_upgrade, :integer
      add :incremental_cost, :decimal
      add :is_facility_all_coverage, :boolean
      add :facility_type, :string
      add :facility_group_codes, {:array, :string}
      add :excluded_facility_codes, {:array, :string}
      add :specific_facility_codes, {:array, :string}
      add :is_risk_share_all_coverage, :boolean
      add :risk_share_all_type, :string
      add :risk_share_all_value, :decimal
      add :rs_member_pays_handling, {:array, :string}

      timestamps()
    end
  end

  def down do
    drop table(:plan_coverages)
  end
end
