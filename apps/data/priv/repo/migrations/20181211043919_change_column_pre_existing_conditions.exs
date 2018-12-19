defmodule Data.Repo.Migrations.ChangeColumnPreExistingConditions do
  use Ecto.Migration
  @moduledoc false

  def up do
    alter table(:plan_pre_existing_conditions) do
      remove :is_existing_member
      remove :is_additional_member
      remove :inner_limit_peso
      remove :inner_limit_session
      remove :inner_limit_percentage
      add :inner_limit_value, :string
      add :is_same_coverage_period_as_account, :boolean
    end
  end

  def down do
    alter table(:plan_pre_existing_conditions) do
      add :is_existing_member, :boolean
      add :is_additional_member, :boolean
      add :inner_limit_peso, :decimal
      add :inner_limit_session, :integer
      add :inner_limit_percentage, :integer
      remove :inner_limit_value
      remove :is_same_coverage_period_as_account
    end
  end
end
