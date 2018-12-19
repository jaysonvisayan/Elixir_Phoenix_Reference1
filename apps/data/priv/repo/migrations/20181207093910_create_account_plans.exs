defmodule Data.Repo.Migrations.CreateAccountPlans do
  use Ecto.Migration

  def up do
    create table(:account_plans, primary_key: false) do
      add :account_code, references(:accounts, column: :code, type: :string, on_delete: :delete_all)
      add :plan_code, :string
      add :plan_name, :string
      add :plan_type, :string
      add :plan_limit_type, :string
      add :plan_limit_amount, :decimal
      add :no_of_members, :integer
      add :no_of_benefits, :integer

      timestamps()
    end
  end

  def down do
    drop table(:account_plans)
  end
end
