defmodule Data.Repo.Migrations.AddBenefit do
  use Ecto.Migration

  def change do
    create table(:benefits, primary_key: false) do
      add :code, :string, primary_key: true
      add :name, :string
      add :type, :string
      add :category, :string
      add :is_loa_facilitated, :boolean
      add :is_reimbursement, :boolean
      add :classification, :string
      add :all_diagnosis, :boolean
      add :all_procedure, :boolean
      add :frequency, :string
      add :acu_type, :string
      add :acu_type_coverage, :string
      add :is_hospital, :boolean
      add :is_clinic, :boolean
      add :is_mobile, :boolean
      add :risk_share_type, :string
      add :risk_share_amount, :decimal
      add :special_handling, :string
      add :created_by, :string
      add :updated_by, :string
      add :version, :string

      timestamps()
    end
  end
end
