defmodule Data.Seeders.Clinic do
  @moduledoc false
  alias Data.Contexts.Clinic, as: CC

  def seed(data) do
    Enum.map(data, fn(params) ->
      case CC.insert_or_update(params) do
        {:ok, data} ->
          data
      end
    end)
  end
end
