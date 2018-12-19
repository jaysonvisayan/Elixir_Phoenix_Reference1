defmodule Data.Repo.Migrations.CreatePlanLimits do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:plan_limits, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plan_code, references(:plans, column: :code, type: :string, on_delete: :delete_all)
      add :coverage_code, {:array, :string}
      add :limit_type, :string
      add :limit_amount, :decimal
      add :extension_limit, :decimal

      timestamps()
    end
  end

  def down do
    drop table(:plan_limits)
  end
end
