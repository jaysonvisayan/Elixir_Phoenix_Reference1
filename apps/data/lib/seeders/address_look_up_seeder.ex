defmodule Data.Seeders.AddressLookUpSeeder do
  @moduledoc false

  alias Data.Contexts.AddressLookUpContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case AddressLookUpContext.insert_address_look_up_seed(params) do
        {:ok, address_look_up} ->
          address_look_up
      end
    end)
  end
end
