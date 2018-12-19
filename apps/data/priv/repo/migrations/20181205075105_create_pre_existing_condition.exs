defmodule Data.Repo.Migrations.CreatePreExistingCondition do
  use Ecto.Migration

  def up do
    create table(:pre_existing_conditions, primary_key: false) do
      add :code, :string, primary_key: true
      add :name, :string

      timestamps()
    end
    create unique_index(:pre_existing_conditions, [:code])
  end

  def down do
    drop table(:pre_existing_conditions)
  end

end
