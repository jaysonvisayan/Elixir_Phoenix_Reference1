defmodule Data.Repo.Migrations.CreateExclusions do
  use Ecto.Migration

  def change do

    create table(:exclusions, primary_key: false) do
      add :code, :string, primary_key: true
      add :name, :string
      add :type, :string
      add :classification, :string
      add :diagnoses, {:array, :string}
      add :procedures, {:array, :string}
      add :policies, {:array, :string}
      add :status, :string
      add :version, :string
      add :inserted_by, :string
      add :updated_by, :string

      timestamps()

    end
  end
end



