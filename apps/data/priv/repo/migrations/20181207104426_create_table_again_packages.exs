defmodule Data.Repo.Migrations.CreateTableAgainPackages do
  use Ecto.Migration

  def up do
    create table(:packages, primary_key: false) do
      add :code, :string, primary_key: true
      add :name, :string

      timestamps()
    end
  end

  def down do
    drop table(:packages)
  end
end
