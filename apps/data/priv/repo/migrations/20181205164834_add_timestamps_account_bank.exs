defmodule Data.Repo.Migrations.AddTimestampsAccountBank do
  use Ecto.Migration

  def change do
    alter table(:account_banks) do
      timestamps()
    end
  end
end
