defmodule Data.Repo.Migrations.CreatePlanHoed do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:plan_hoed, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plan_code, references(:plans, column: :code, type: :string, on_delete: :delete_all)
      add :civil_status, {:array, :string}
      add :dependent_hierarchy, {:array, :map}

      timestamps()
    end
  end

  def down do
    drop table(:plan_hoed)
  end
end
