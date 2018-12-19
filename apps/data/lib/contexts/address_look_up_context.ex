defmodule Data.Contexts.AddressLookUpContext do
  @moduledoc false

  import Ecto.{Query, Changeset}, warn: false
  alias Data.{
    Schemas.AddressLookUp,
    Repo
  }

  def insert_address_look_up_seed(params) do
    params
    |> get_address_look_up()
    |> create_update_address_look_up(params)
  end

  defp create_update_address_look_up(address_look_up, params) when is_nil(address_look_up) do
    %AddressLookUp{}
    |> AddressLookUp.changeset(params)
    |> Repo.insert()
  end

  defp create_update_address_look_up(address_look_up, params) do
    address_look_up
    |> AddressLookUp.changeset(params)
    |> Repo.update()
  end

  def get_address_look_up(params) do
    AddressLookUp
    |> Repo.get_by(city_municipal: params.city_municipal)
  end

  def get_address_look_up_by_city(city) do
    AddressLookUp
    |> Repo.get_by(city_municipal: city)
  end

  def get_address_look_up_by_province(province) do
    AddressLookUp
    |> where([alu], alu.province == ^province)
    |> limit(1)
    |> Repo.one()
  end

  def get_address_look_up_by_region(region) do
    AddressLookUp
    |> where([alu], alu.region == ^region)
    |> limit(1)
    |> Repo.one()
  end

end
