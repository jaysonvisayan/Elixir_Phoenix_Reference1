defmodule Data.Repo.Migrations.RemoveUnusedFieldsInDiagnosis do
  use Ecto.Migration

  def up do
    alter table(:diagnoses) do
      remove :group_code
      remove :group_desc
      remove :is_dreaded
      remove :is_congenital
      remove :standard
    end
  end

  def down do
    alter table(:diagnoses) do
      add :group_code, :string
      add :group_desc, :string
      add :is_dreaded, :boolean
      add :is_congenital, :boolean
      add :standard, :string
    end
  end

end
