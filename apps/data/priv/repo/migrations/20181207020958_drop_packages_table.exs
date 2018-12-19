defmodule Data.Repo.Migrations.DropPackagesTable do
  use Ecto.Migration

  def up do
    drop table(:packages)
  end

  def down do
    create table(:packages, primary_key: false) do
      add :code, :string, primary_key: true
      add :name, :string

      timestamps()
    end
  end
end
