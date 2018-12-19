defmodule Data.Repo.Migrations.ChangeColumnPlanBenefitLimits do
  use Ecto.Migration
  @moduledoc false

  def up do
      alter table(:plan_benefits) do
      remove :limit_peso
      remove :limit_session
      remove :limit_percentage
      add :limit_value, :string
    end
  end

  def down do
      alter table(:plan_benefits) do
      add :limit_peso, :decimal
      add :limit_session, :integer
      add :limit_percentage, :decimal
      remove :limit_value
    end
  end
end
