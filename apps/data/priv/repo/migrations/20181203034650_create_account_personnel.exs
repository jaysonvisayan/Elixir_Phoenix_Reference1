defmodule Data.Repo.Migrations.CreateAccountPersonnel do
  use Ecto.Migration

  def up do
    create table(:account_personnels, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account_code, references(:accounts, column: :code, type: :string, on_delete: :delete_all)
      add :personnel, :string
      add :specialization, :string
      add :location, :string
      add :schedule, :string
      add :no_of_personnel, :integer
      add :payment_mode, :string
      add :retainer_fee, :string
      add :amount, :decimal
    end
  end

  def down do
    drop table(:account_personnels)
  end
end
