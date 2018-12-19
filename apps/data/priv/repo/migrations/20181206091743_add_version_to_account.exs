defmodule Data.Repo.Migrations.AddVersionToAccount do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :version, :string
    end
  end
end
