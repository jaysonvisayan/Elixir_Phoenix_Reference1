defmodule Data.Seeders.PlanSeeder do
  @moduledoc false
  alias Data.Contexts.PlanContext, as: PC

  def seed(data) do
    Enum.map(data, fn(params) ->
      case PC.insert_plan_seed(params) do
        {:ok, data} ->
          data
      end
    end)
  end
end
