defmodule Data.Schemas.AddressLookUp do
  @moduledoc false

  use Data.Schema

  schema "address_look_ups" do
    field :region, :string
    field :region_name, :string
    field :province, :string
    field :city_municipal, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :region,
      :region_name,
      :province,
      :city_municipal
    ])
  end

end
