defmodule Data.Repo.Migrations.CreatePlanBenefits do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:plan_benefits, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plan_code, references(:plans, column: :code, type: :string, on_delete: :delete_all)
      add :benefit_code, references(:benefits, column: :code, type: :string, on_delete: :delete_all)
      add :coverage_code, {:array, :string}
      add :limit_type, :string
      add :limit_peso, :decimal
      add :limit_session, :integer
      add :limit_percentage, :decimal

      timestamps()
    end
  end

  def down do
    drop table(:plan_benefits)
  end
end
