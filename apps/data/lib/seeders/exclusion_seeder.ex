defmodule Data.Seeders.ExclusionSeeder do
  @moduledoc false
  alias Data.Contexts.ExclusionContext, as: EC

  def seed(data) do
    Enum.map(data, fn(params) ->
      case EC.insert_exclusion_seed(params) do
        {:ok, data} ->
          data
      end
    end)
  end
end

