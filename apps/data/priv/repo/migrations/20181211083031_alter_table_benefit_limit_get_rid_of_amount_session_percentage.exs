defmodule Data.Repo.Migrations.AlterTableBenefitLimitGetRidOfAmountSessionPercentage do
  use Ecto.Migration

  def up do
    alter table(:benefit_limits) do
      remove :limit_amount
      remove :limit_session
      remove :limit_percentage
      add :limit_value, :string
    end
  end

  def down do
    alter table(:benefit_limits) do
      remove :limit_value
      add :limit_amount, :decimal
      add :limit_session, :string
      add :limit_percentage, :integer
    end
  end

end
