defmodule Data.Repo.Migrations.CreateDiagnosis do
  use Ecto.Migration

  def change do
    create table(:diagnoses, primary_key: false) do
      add :code, :string, primary_key: true
      add :desc, :string
      add :group_code, :string
      add :group_desc, :string
      add :is_dreaded, :boolean
      add :is_congenital, :boolean
      add :standard, :string

      timestamps()
    end
  end
end
