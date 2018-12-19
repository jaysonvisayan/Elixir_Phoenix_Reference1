defmodule :"Elixir.Data.Repo.Migrations.AddFieldsInPre-existingConditions" do
  use Ecto.Migration

  def up do
    alter table(:pre_existing_conditions) do
      add :inserted_by, :string
      add :updated_by, :string
      add :category, :string
      add :version, :string
    end
  end

  def down do
    alter table(:pre_existing_conditions) do
      remove :inserted_by
      remove :updated_by
      remove :category
      remove :version
    end
  end
end
