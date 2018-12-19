defmodule Data.Repo.Migrations.CreatePecConditions do
  use Ecto.Migration

  def up do
    create table(:pre_existing_condition_conditions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :pre_existing_condition_code, references(:pre_existing_conditions, column: :code, type: :string, on_delete: :delete_all)
      add :member_type, :string
      add :disease_category, :string
      add :duration, :integer
      add :inner_limit_type, :string
      add :inner_limit_value, :string
      add :is_same_coverage_period_as_account, :boolean

      timestamps()
    end
  end

  def down do
    drop table(:pre_existing_condition_conditions)
  end

end
