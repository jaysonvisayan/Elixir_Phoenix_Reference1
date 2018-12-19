defmodule Data.Repo.Migrations.CreateAccountAddress do
  use Ecto.Migration

  def up do
    create table(:account_addresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account_code, references(:accounts, column: :code, type: :string, on_delete: :delete_all)
      add :type, :string
      add :address_line_1, :string
      add :address_line_2, :string
      add :city, :string
      add :province, :string
      add :region, :string
      add :country, :string
      add :postal, :string
    end
  end

  def down do
    drop table(:account_addresses)
  end
end
