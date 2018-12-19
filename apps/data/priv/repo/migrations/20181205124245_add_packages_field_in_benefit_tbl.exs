defmodule Data.Repo.Migrations.AddPackagesFieldInBenefitTbl do
  use Ecto.Migration

  def up do
    alter table(:benefits) do
      add :packages, {:array, :string}
    end
  end

  def down do
    alter table(:benefits) do
      remove :packages
    end
  end
end
