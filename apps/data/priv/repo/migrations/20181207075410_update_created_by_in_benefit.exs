defmodule Data.Repo.Migrations.UpdateCreatedByInBenefit do
  use Ecto.Migration

  def up do
    alter table(:benefits) do
      remove :created_by
      remove :special_handling
      remove :risk_share_type
      add :inserted_by, :string
      add :member_pays_handling, :string
      add :risk_share, :string
    end
  end

  def down do
    alter table(:benefits) do
      add :created_by, :string
      add :special_handling, :string
      add :risk_share_type, :string
      remove :inserted_by
      remove :member_pays_handling
      remove :risk_share
    end
  end
end
