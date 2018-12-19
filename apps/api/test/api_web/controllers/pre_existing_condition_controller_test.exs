defmodule ApiWeb.PreExistingConditionControllerTest do
  use ApiWeb.ConnCase

  describe "Create Pre-Existing Condition" do
    test "with valid params" do
      d1 = insert(:diagnosis, code: Faker.Code.isbn())
      params = %{
        code: Faker.Code.iban(),
        name: Faker.Name.name(),
        diagnosis: [d1.code],
        conditions: [
          %{
            member_type: "P",
            disease_category: "D",
            duration: "1000",
            inner_limit_type: "S",
            inner_limit_value: "999",
            is_same_coverage_period_as_account: "false"
          },
          %{
            member_type: "D",
            disease_category: "ND",
            duration: "9999",
            inner_limit_type: "S",
            inner_limit_value: "999",
            is_same_coverage_period_as_account: true
          },
          %{
            member_type: "P",
            disease_category: "D",
            duration: "2500",
            inner_limit_type: "S",
            inner_limit_value: "999",
            is_same_coverage_period_as_account: true
          }
        ]
      }
      route = Routes.pre_existing_condition_path(build_conn(), :create_pre_existing_condition)
      conn = post(
        build_conn(),
        route,
        params
      )
      json_response(conn, 200)
    end

    test "with invalid params" do
      route = Routes.pre_existing_condition_path(build_conn(), :create_pre_existing_condition)
      conn = post(
        build_conn(),
        route,
        %{}
      )
      json_response(conn, 400)
    end
  end

  describe "search pre existing condition" do
    test "with valid params returns data" do
      pec = insert(:pre_existing_conditions, code: "1", name: "test", category: "Pre-existing Condition", updated_by: "masteradmin")
      conn = post(build_conn(), "/api/v1/pec/get_pre-existing_conditions", %{page_number: 1, search_value: "", display_per_page: "5", sort_by: "code", order_by: "asc"})
      assert List.first(json_response(conn, 200)["pre_existing_conditions"])["code"] == pec.code
    end

    test "with invalid params/400 returns validate required" do
      conn = post(build_conn(), "/api/v1/pec/get_pre-existing_conditions", %{page_number: 1, search_value: "", sort_by: "code", order_by: "asc"})
      assert json_response(conn, 400)["errors"]["display_per_page"] == "Enter display_per_page"
    end
  end

end

