defmodule Data.Repo.Migrations.CreatePlanPreExistingCondition do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:plan_pre_existing_conditions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plan_code, references(:plans, column: :code, type: :string, on_delete: :delete_all)
      add :pec_code, references(:pre_existing_conditions, column: :code, type: :string, on_delete: :delete_all)
      add :is_existing_member, :boolean
      add :is_additional_member, :boolean
      add :member_type, :string
      add :disease_category, :string
      add :duration, :integer
      add :inner_limit_type, :string
      add :inner_limit_peso, :decimal
      add :inner_limit_session, :integer
      add :inner_limit_percentage, :integer

      timestamps()
    end
  end

  def down do
    drop table(:plan_pre_existing_conditions)
  end
end
