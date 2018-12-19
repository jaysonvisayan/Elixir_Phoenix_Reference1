defmodule Data.Repo.Migrations.CreateFacilities do
  use Ecto.Migration
  @moduledoc false

  def up do
    create table(:facilities, primary_key: false) do
      add :code, :string, primary_key: true
      add :name, :string
      add :type, :string
    end
  end

  def down do
    drop table(:facilities)
  end
end
