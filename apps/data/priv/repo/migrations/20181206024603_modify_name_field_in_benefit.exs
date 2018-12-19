defmodule Data.Repo.Migrations.AddPackagesFieldInBenefit do
  use Ecto.Migration

  def change do
    alter table(:benefits) do
      modify :name, :text
    end
  end
end
