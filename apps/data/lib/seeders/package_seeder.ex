defmodule Data.Seeders.PackageSeeder do
  @moduledoc false
  alias Data.Contexts.PackageContext, as: PC

  def seed(data) do
    Enum.map(data, fn(params) ->
      case PC.insert_package_seed(params) do
        {:ok, data} ->
          data
      end
    end)
  end
end
