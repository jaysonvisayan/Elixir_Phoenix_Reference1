defmodule Data.Seeders.ClinicTest do
  @moduledoc false

  use Data.SchemaCase
  alias Data.Seeders.Clinic, as: SC

  @tag :unit
  describe "seed clinic" do
    test "with new clinic" do
      code = "1234"
      [c] = SC.seed([data(code)])
      assert c.code == code
    end

    test "update existing clinic" do
      code = "1234"
      insert(:clinic, code: code)

      [c] = SC.seed([data(code)])
      assert c.code == code
    end
  end

  defp data(code) do
    %{
      code: code,
      name: generate_data(1..255),
      description: generate_data(1..255)
    }
  end

  defp generate_data(range) do
    range
    |> Faker.Lorem.characters()
    |> to_string()
  end
end
