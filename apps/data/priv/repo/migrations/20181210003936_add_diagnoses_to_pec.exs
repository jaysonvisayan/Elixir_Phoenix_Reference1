defmodule Data.Repo.Migrations.AddDiagnosesToPec do
  use Ecto.Migration

  def change do
  end

  def up do
    alter table(:pre_existing_conditions) do
      add :diagnoses, {:array, :string}
      add :conditions, {:array, :jsonb}
    end
  end

  def down do
    alter table(:pre_existing_conditions) do
      remove :diagnoses
      remove :conditions
    end
  end

end
