defmodule Data.Repo.Migrations.CreatePlans do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:plans, primary_key: false) do
      add :code, :string, primary_key: true
      add :category, :string
      add :name, :string
      add :description, :string
      add :type, :string
      add :classification, :string
      add :applicability, :string
      add :phic_status, :string
      add :exclusion_codes, {:array, :string}
      add :grace_principal_type, :string
      add :grace_principal_value, :integer
      add :grace_dependent_type, :string
      add :grace_dependent_value, :integer
      add :max_no_dependents, :integer
      add :default_effective_date, :string
      add :is_no_outright_denial, :boolean
      add :is_loa_facilitated, :boolean
      add :is_reimbursement, :boolean
      add :loa_validity, :integer
      add :application_of_limit, :string
      add :is_sonny_medina, :boolean
      add :is_hospital_bill, :boolean
      add :is_professional_fee, :boolean
      add :principal_schedule, :string
      add :dependent_schedule, :string

      timestamps()
    end
  end

  def down do
    drop table(:plans)
  end
end
