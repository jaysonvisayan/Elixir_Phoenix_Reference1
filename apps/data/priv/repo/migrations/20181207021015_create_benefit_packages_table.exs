defmodule Data.Repo.Migrations.CreateBenefitPackagesTable do
  use Ecto.Migration

  def up do
    create table(:benefit_packages, primary_key: false) do
      add :code, :string, primary_key: true
      add :name, :string

      timestamps()
    end
  end

  def down do
    drop table(:benefit_packages)
  end
end
