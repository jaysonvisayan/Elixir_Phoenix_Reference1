defmodule ApiWeb.BenefitControllerTest do
  use ApiWeb.ConnCase

  defp data(key \\ :test, val \\ "test") do
    Map.put(%{
      code: "Code",
      name: Faker.Name.title(),
      frequency: Faker.Name.title(),
      category: "ma",
      acu_type: "r",
      acu_type_coverage: "op",
      risk_share: "cp",
      member_pays_handling: "MP",
      is_loa_facilitated: true,
      is_reimbursement: true,
      is_hospital: true,
      is_clinic: true,
      is_mobile: true,
      all_diagnosis: true,
      all_procedure: true,
      risk_share_amount: 1000,
      packages: ["pckg-001", "pckg-002"],
      limit: [
        %{
          limit_type: "S",
          limit_value: "1000"
        },
        %{
          limit_type: "S",
          limit_value: "1000"
        }
      ]
    }, key, val)
  end

  describe "get_benefits" do
    test "with valid params" do
      benefit = insert(:benefit, code: "1", name: "asd", type: "riders", updated_at: DateTime.utc_now(), updated_by: "me")
      insert(:benefit_limit, limit_value: "1", limit_type: "Peso", coverage_codes: ["DENTL", "OPL"], benefit_code: benefit.code)
      benefit2 = insert(:benefit, code: "2", name: "asd", type: "riders", updated_at: DateTime.utc_now(), updated_by: "me")
      insert(:benefit_limit, limit_value: "1", limit_type: "Peso", coverage_codes: ["MTRNTY"], benefit_code: benefit2.code)
      conn = post(build_conn(), "/api/v1/benefits/get_benefits", %{page_number: 1, search_value: "", display_per_page: "5", sort_by: "coverages", order_by: "desc"})
      assert List.first(json_response(conn, 200)["benefits"])["code"] == benefit2.code
    end

    test "with invalid params/400" do
      insert(:benefit, code: "1")
      conn = post(build_conn(), "/api/v1/benefits/get_benefits", %{page_number: 1, search_value: "", display_per_page: "", sort_by: "code", order_by: "asc"})
      assert json_response(conn, 400)["errors"]["display_per_page"] == "Enter display_per_page"
    end

    test "with no results found" do
      benefit = insert(:benefit, code: "1", name: "asd", type: "riders", updated_at: DateTime.utc_now(), updated_by: "me")
      insert(:benefit_limit, limit_value: "1", limit_type: "Peso", coverage_codes: ["DENTL", "OPL"], benefit_code: benefit.code)
      conn = post(build_conn(), "/api/v1/benefits/get_benefits", %{page_number: 1, search_value: "asdasd", display_per_page: "1", sort_by: "code", order_by: "asc"})
      assert json_response(conn, 400)["errors"] == "No benefits matched your search"
    end
  end

  describe "Create Benefit" do
    test "with valid params" do
      insert(:package, code: "pckg-001")
      insert(:package, code: "pckg-002")
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data())

      assert json_response(conn, 200)["code"] == data().code
    end

    test "with invalid code (should be at most 60 char)" do
      params = data(:code, Faker.Lorem.paragraph(20))
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", params)

      assert json_response(conn, 400)["errors"]["code"] == "code should be at most 60 character(s)"
    end

    test "with invalid name (should be at most 400 char)" do
      params = data(:name, Faker.Lorem.paragraph(50))
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", params)

      assert json_response(conn, 400)["errors"]["name"] == "name should be at most 400 character(s)"
    end

    test "with invalid code (is already taken)" do
      insert(:benefit, code: "Code")
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data())

      assert json_response(conn, 400)["errors"]["code"] == "code is already taken"
    end

    test "with invalid is_loa_facilitated (is invalid)" do
      params = data(:is_loa_facilitated, "test")
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", params)

      assert json_response(conn, 400)["errors"]["is_loa_facilitated"] == "is_loa_facilitated is invalid"
    end

    test "with invalid package (not existing)" do
      insert(:package, code: "pckg-001")
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data())

      assert json_response(conn, 400)["errors"]["packages"] == "packages not existing: pckg-002"
    end

    test "with invalid risk share amount (is invalid)" do
      insert(:package, code: "pckg-001")
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data(:risk_share_amount, "test"))

      assert json_response(conn, 400)["errors"]["risk_share_amount"] == "risk_share_amount is invalid"
    end

    test "with invalid limit type (is invalid row 1)" do
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data(:limit, [%{limit_type: "PA", limit_value: "1000"}]))

      assert json_response(conn, 400)["errors"]["limit_type (row 1)"] == "limit_type (row 1) is invalid"
    end

    test "with invalid limit amount (is invalid row 1)" do
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data(:limit, [%{limit_type: "S", limit_value: 1212}]))

      assert json_response(conn, 400)["errors"]["limit_value (row 1)"] == "limit_value (row 1) is invalid"
    end

    test "with invalid limit amount string but non numerical (is invalid row 1)" do
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data(:limit, [%{limit_type: "S", limit_value: "2313asdfasdfas"}]))

      assert json_response(conn, 400)["errors"]["limit_value (row 1)"] == "limit_value (row 1) is invalid"
    end

    test "with invalid (Enter limit)" do
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data(:limit, []))

      assert json_response(conn, 400)["errors"]["limit"] == "Enter limit"
    end

    test "with invalid (limit value must be 6 numeric characters)" do
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data(:limit, [%{limit_type: "S", limit_value: "1200000"}]))

      assert json_response(conn, 400)["errors"]["limit_value (row 1)"] == "limit_value (row 1) up to 6 numeric characters only without decimal numbers"
    end

    test "with invalid (limit value must be 8 numeric characters)" do
      conn = post(build_conn(), "/api/v1/benefits/create_benefit_acu", data(:limit, [%{limit_type: "S", limit_value: "1200000.00"}]))

      assert json_response(conn, 400)["errors"]["limit_value (row 1)"] == "limit_value (row 1) up to 8 numeric characters only with decimal numbers"
    end
  end

  describe "get_benefit_acu" do
    test "with valid params" do
      insert(:benefit_package, code: "PCODE01", name: "Test1")
      insert(:benefit_package, code: "PCODE02", name: "Test2")
      insert(
        :benefit,
        code: "TESTCODE01",
        name: "Test",
        type: "rides",
        updated_at: DateTime.utc_now(),
        updated_by: "masteradmin")
        # packages: [%{code: package1.code, name: package1.name}, %{code: package2.code, name: package2.name}])
      conn = post(build_conn(), "api/v1/benefits/get_benefit_acu",
                             %{
                               code: "TESTCODE01"
                             })
      assert json_response(conn, 200)
    end

    test "with invalid params/400" do
      insert(:benefit_package, code: "PCODE01", name: "Test1")
      insert(:benefit_package, code: "PCODE02", name: "Test2")
      insert(
        :benefit,
        code: "TESTCODE01",
        name: "Test",
        type: "rides",
        updated_at: DateTime.utc_now(),
        updated_by: "masteradmin")
        # packages: [%{code: package1.code, name: package1.name}, %{code: package2.code, name: package2.name}])
      conn = post(build_conn(), "api/v1/benefits/get_benefit_acu",
                             %{
                               code: ""
                             })
      assert json_response(conn, 400)
    end
  end
end
