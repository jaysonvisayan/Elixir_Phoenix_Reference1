defmodule Data.Repo.Migrations.AddClinic do
  use Ecto.Migration

  def change do
    create table(:clinics, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :string
      add :name, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:clinics, [:code])
  end
end
