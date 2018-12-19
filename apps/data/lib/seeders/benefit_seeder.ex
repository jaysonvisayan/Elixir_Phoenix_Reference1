defmodule Data.Seeders.BenefitSeeder do
  @moduledoc false
  alias Data.Contexts.BenefitContext, as: BC

  def seed(data) do
    Enum.map(data, fn(params) ->
      case BC.insert_benefit_seed(params) do
        {:ok, data} ->
          data
      end
    end)
  end
end
