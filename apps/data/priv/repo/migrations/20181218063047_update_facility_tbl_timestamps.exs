defmodule Data.Repo.Migrations.UpdateFacilityTblTimestamps do
  use Ecto.Migration

  def change do
    alter table(:facilities) do
      timestamps()
    end
  end
end
