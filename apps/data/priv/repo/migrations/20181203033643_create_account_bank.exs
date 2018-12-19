defmodule Data.Repo.Migrations.CreateAccountBank do
  use Ecto.Migration

  def up do
    create table(:account_banks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account_code, references(:accounts, column: :code, type: :string, on_delete: :delete_all)
      add :payment_mode, :string
      add :payee_name, :string
      add :bank_account, :string
      add :bank_name, :string
      add :bank_branch, :string
      add :authority_to_debit, :boolean
      add :authorization_form, :string
    end
  end

  def down do
    drop table(:account_banks)
  end
end
