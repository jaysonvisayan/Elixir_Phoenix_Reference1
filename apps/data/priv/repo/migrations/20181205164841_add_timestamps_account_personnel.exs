defmodule Data.Repo.Migrations.AddTimestampsAccountPersonnel do
  use Ecto.Migration

  def change do
    alter table(:account_personnels) do
      timestamps()
    end
  end
end
