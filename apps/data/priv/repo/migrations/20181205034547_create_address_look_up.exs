defmodule Data.Repo.Migrations.CreateAddressLookUp do
  use Ecto.Migration

  def up do
    create table(:address_look_ups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :region, :string
      add :region_name, :string
      add :province, :string
      add :city_municipal, :string
    end
  end

  def down do
    drop table(:address_look_ups)
  end
end
