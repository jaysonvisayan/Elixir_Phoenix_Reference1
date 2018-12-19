defmodule Data.Repo.Migrations.CreateAccountContact do
  use Ecto.Migration

  def up do
    create table(:account_contacts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account_code, references(:accounts, column: :code, type: :string, on_delete: :delete_all)
      add :type, :string
      add :name, :string
      add :department, :string
      add :designation, :string
      add :telephone, {:array, :string}
      add :mobile, {:array, :string}
      add :fax, {:array, :string}
      add :email_address, :string
      add :ctc, :string
      add :ctc_date_issued, :date
      add :ctc_place_issued, :string
      add :passport, :string
      add :passport_date_issued, :date
      add :passport_place_issued, :string
    end
  end

  def down do
    drop table(:account_contacts)
  end
end
