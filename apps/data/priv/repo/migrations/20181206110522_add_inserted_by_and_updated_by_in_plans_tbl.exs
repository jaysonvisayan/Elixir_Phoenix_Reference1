defmodule Data.Repo.Migrations.AddInsertedByAndUpdatedByInPlansTbl do
  use Ecto.Migration

  def up do
    alter table(:plans) do
      add :inserted_by, :string
      add :updated_by, :string
    end
  end

  def down do
    alter table(:plans) do
      remove :inserted_by
      remove :updated_by
    end
  end
end
