defmodule Data.Repo.Migrations.CreateAccountApprovers do
  use Ecto.Migration

  def up do
    create table(:account_approvers, primary_key: false) do
      add :account_code, references(:accounts, column: :code, type: :string, on_delete: :delete_all)
      add :username, :string
      add :name, :string
      add :telephone, :string
      add :mobile, :string
      add :email, :string

      timestamps()
    end
  end

  def down do
    drop table(:account_approvers)
  end
end
