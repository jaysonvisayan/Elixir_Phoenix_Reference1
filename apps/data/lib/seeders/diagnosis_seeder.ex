defmodule Data.Seeders.DiagnosisSeeder do
  @moduledoc false

  alias Data.Contexts.DiagnosisContext

  def seed(data) do
    Enum.map(data, fn(params) ->
      case DiagnosisContext.insert_diagnosis_seed(params) do
        {:ok, d} ->
          d
      end
    end)
  end
end
