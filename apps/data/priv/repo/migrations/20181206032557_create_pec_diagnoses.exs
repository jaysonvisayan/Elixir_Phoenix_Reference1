defmodule Data.Repo.Migrations.CreatePecDiagnoses do
  use Ecto.Migration

  def up do
    create table(:pre_existing_condition_diagnoses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :pre_existing_condition_code, references(:pre_existing_conditions, column: :code, type: :string, on_delete: :delete_all)
      add :diagnosis_code, references(:diagnoses, column: :code, type: :string, on_delete: :delete_all)

      timestamps()
    end
  end

  def down do
    drop table(:pre_existing_condition_diagnoses)
  end

end
