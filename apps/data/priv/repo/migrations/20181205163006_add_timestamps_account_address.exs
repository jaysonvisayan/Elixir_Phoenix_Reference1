defmodule Data.Repo.Migrations.AddTimestampsAccountAddress do
  use Ecto.Migration

  def change do
    alter table(:account_addresses) do
      timestamps()
    end
  end
end
