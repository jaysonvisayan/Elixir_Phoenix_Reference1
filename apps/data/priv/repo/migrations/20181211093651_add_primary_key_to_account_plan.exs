defmodule Data.Repo.Migrations.AddPrimaryKeyToAccountPlan do
  use Ecto.Migration

  def up do
    alter table(:account_plans) do
      add :id, :binary_id, primary_key: true
    end
  end

  def down do
    alter table(:account_plans) do
      remove :id
    end
  end
end


