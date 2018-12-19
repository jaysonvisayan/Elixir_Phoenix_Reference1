defmodule Data.Repo.Migrations.AddTimestampsAndAlterAccountContact do
  use Ecto.Migration

  def change do
    alter table(:account_contacts) do
      remove :telephone
      remove :mobile
      remove :fax

      add :telephone, {:array, :map}
      add :mobile, {:array, :map}
      add :fax, {:array, :map}
      timestamps()
    end
  end
end
