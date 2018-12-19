defmodule Data.Repo.Migrations.AddPrimaryKeyToAccountApprover do
  use Ecto.Migration

  def up do
    alter table(:account_approvers) do
      add :id, :binary_id, primary_key: true
    end
  end

  def down do
    alter table(:account_approvers) do
      remove :id
    end
  end
end
