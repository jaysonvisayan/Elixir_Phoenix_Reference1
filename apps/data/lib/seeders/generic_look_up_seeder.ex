defmodule Data.Seeders.GenericLookUpSeeder do
  @moduledoc false

  alias Data.Contexts.GenericLookUpContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case GenericLookUpContext.insert_generic_look_up_seed(params) do
        {:ok, generic_look_up} ->
          generic_look_up
      end
    end)
  end
end
