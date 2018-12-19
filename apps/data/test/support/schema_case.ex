defmodule Data.SchemaCase do
  @moduledoc "Base schema for tests"
  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Data.SchemaCase
      import Data.Factory
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Data.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Data.Repo, {:shared, self()})
    end

    :ok
  end
end
