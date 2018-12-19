defmodule Data.Contexts.PreExistingConditionContextTest do

  use Data.SchemaCase
  alias Data.Contexts.PreExistingConditionContext, as: PECC

  describe "search pec" do
    test "validate parameters returns valid" do
      params = %{
        "search_value" => Faker.Code.isbn,
        "page_number" => 1,
        "display_per_page" => 5,
        "sort_by" => "code",
        "order_by" => "asc"
      }

      {is_valid, changeset} = PECC.validate_params(:search, params)

      assert is_valid == true
      assert changeset.valid? == true
    end

    test "validate parameters returns error validate required" do
      params = %{
        "search_value" => Faker.Code.isbn,
        "sort_by" => "code",
        "order_by" => "asc"
      }

      {is_valid, changeset} = PECC.validate_params(:search, params)

      assert is_valid == false
      assert changeset.valid? == false
      assert changeset.errors == [page_number: {"is required", [validation: :required]}, display_per_page: {"is required", [validation: :required]}]
      assert Enum.count(changeset.errors) == 2
    end

    test "validate parameters returns error in looking search_value parameter" do
      params = %{
        "page_number" => 1,
        "display_per_page" => 5,
        "sort_by" => "code",
        "order_by" => "asc"
      }

      {is_valid, changeset} = PECC.validate_params(:search, params)

      assert is_valid == false
      assert changeset.valid? == false
      assert changeset.errors == [search_value: {"is not in the parameters", []} ]
      assert Enum.count(changeset.errors) == 1
    end

    test "get data with valid parameters returns a result" do
      insert(:pre_existing_conditions, code: "test", name: "test2", category: "Pre-Existing Condition", updated_by: "masteradmin")
      params = %{
        "search_value" => "test",
        "page_number" => 1,
        "display_per_page" => 5,
        "sort_by" => "code",
        "order_by" => "asc"
      }

      {_, changeset} = PECC.validate_params(:search, params)
      results = PECC.get_pre_existing_conditions(changeset.changes, :search)

      assert Enum.count(results) == 1
    end

    test "get data with valid parameters returns no result" do
      params = %{
        "search_value" => Faker.Code.isbn,
        "page_number" => 1,
        "display_per_page" => 5,
        "sort_by" => "code",
        "order_by" => "asc"
      }

      {_, changeset} = PECC.validate_params(:search, params)
      results = PECC.get_pre_existing_conditions(changeset.changes, :search)

      assert Enum.empty?(results) == true
    end
  end
end

