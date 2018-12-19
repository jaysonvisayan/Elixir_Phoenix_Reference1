defmodule Data.Repo.Migrations.CreateGenericLookUp do
  use Ecto.Migration

  def up do
    create table(:generic_look_ups, primary_key: false) do
      add :code, :string, primary_key: true
      add :type, :string, primary_key: true
      add :name, :string
      add :description, :string
    end
  end

  def down do
    drop table(:generic_look_ups)
  end
end
