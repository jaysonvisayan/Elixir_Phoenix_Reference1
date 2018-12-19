defmodule Data.Repo.Migrations.CreatePlanAgeEligibility do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:plan_age_eligibilities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plan_code, references(:plans, column: :code, type: :string, on_delete: :delete_all)
      add :member_type, :string
      add :min_age, :integer
      add :max_age, :integer

      timestamps()
    end
  end

  def down do
    drop table(:plan_age_eligibilities)
  end
end
