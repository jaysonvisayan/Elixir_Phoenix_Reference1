defmodule Data.Repo.Migrations.CreateBenefitLimit do
  use Ecto.Migration

  def change do
    create table(:benefit_limits, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :benefit_code, references(:benefits, column: :code, type: :string, on_delete: :delete_all)
      add :limit_type, :string
      add :limit_amount, :decimal
      add :limit_session, :string
      add :limit_percentage, :integer
      add :is_quadrant, :boolean
      add :is_site, :boolean
      add :limit_area_site, :string
      add :limit_classification, :string
      add :coverage_codes, {:array, :string}

    end
  end
end
