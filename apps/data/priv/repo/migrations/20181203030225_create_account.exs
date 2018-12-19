defmodule Data.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def up do
    create table(:accounts, primary_key: false) do
      add :code, :string, primary_key: true
      add :status, :string
      add :step, :string
      add :photo, :string
      add :segment, :string
      add :name, :string
      add :type, :string
      add :industry, :string
      add :effective_date, :date
      add :expiry_date, :date
      add :address_same_as_billing, :boolean
      add :tin, :string
      add :vat_status, :string
      add :previous_carrier, :string
      add :attachment_point, :string
      add :bank_same_as_funding, :boolean
      add :inserted_by, :string
      add :updated_by, :string

      timestamps()
    end
    create unique_index(:accounts, [:code])
  end

  def down do
    drop table(:accounts)
  end
end
