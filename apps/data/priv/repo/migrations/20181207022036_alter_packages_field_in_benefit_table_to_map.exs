defmodule Data.Repo.Migrations.AlterPackagesFieldInBenefitTableToMap do
  use Ecto.Migration

  def up do
    alter table(:benefits) do
      remove :packages
      add :packages, {:array, :map}
    end
  end

  def down do
    alter table(:benefits) do
      remove :packages
      add :packages, {:array, :string}
    end
  end
end
