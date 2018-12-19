defmodule Data.Seeders.AccountSeeder do
  @moduledoc false
  alias Data.Contexts.AccountContext, as: AC

  def seed(data) do
    Enum.map(data, fn(params) ->
      case AC.insert_account_seed(params) do
        {:ok, data} ->
          data
      end
    end)
  end
end
