defmodule ApiWeb.PlanControllerTest do
  use ApiWeb.ConnCase

  defp data(key \\ :test, val \\ "test") do
    Map.put(%{
      is_no_outright_denial: true,
      is_loa_facilitated: true,
      is_hospital_bill: true,
      is_professional_fee: true,
      is_sonny_medina: true,
      is_reimbursement: true,
      code: "PLN-001",
      name: "PLN-NAME",
      description: "DESCRIPTION",
      type: "PP",
      phic_status: "required to file",
      applicability: "P",
      classification: "S",
      grace_principal_type: "days",
      grace_dependent_type: "",
      dependent_schedule: "",
      principal_schedule: "",
      default_effective_date: "",
      application_of_limit: "LT",
      max_no_dependents: 20,
      loa_validity: 10,
      grace_principal_value: 1000,
      grace_dependent_value: "",
      exclusion_codes: "",
      plan_pecs: "",
      plan_benefits: "",
      plan_coverages: "",
      plan_limits: "",
      plan_age_eligibilities: "",
      plan_hoed: ""
    }, key, val)
  end

  describe "get_plans" do
    test "with valid params" do
      plan = insert(:plan, code: "1")
      conn = post(build_conn(), "/api/v1/plans/get_plans", %{page_number: 1, search_value: "", display_per_page: "5", sort_by: "code", order_by: "asc"})
      assert List.first(json_response(conn, 200)["plans"])["code"] == plan.code
    end

    test "with invalid params/400" do
      insert(:plan, code: "1")
      conn = post(build_conn(), "/api/v1/plans/get_plans", %{page_number: 1, search_value: "", display_per_page: "", sort_by: "code", order_by: "asc"})
      assert json_response(conn, 400)["errors"]["display_per_page"] == "Enter display_per_page"
    end
  end

  describe "Create Medical Plan" do
    test "with valid parameters" do
      # conn = post(build_conn(), "/api/v1/plans/create_medical_plan", %{})
    end
  end

  describe "get_plan" do
    test "with valid params exclusion tab" do
      insert(:plan,
        code: "TEST001",
        category: "Medical",
        name: "MedPlanTest",
        description: "DescTest",
        type: "Test",
        classification: "Standard",
        applicability: "Principal",
        phic_status: "Required to file",
        exclusion_codes: ["EXC010", "EXC011"],
        grace_principal_type: "A",
        grace_principal_value: 5,
        grace_dependent_type: "B",
        grace_dependent_value: 10,
        max_no_dependents: 10,
        default_effective_date: "12-12-2018",
        is_no_outright_denial: true,
        is_loa_facilitated: true,
        is_reimbursement: true,
        loa_validity: 1,
        application_of_limit: "A",
        is_sonny_medina: true,
        is_hospital_bill: true,
        is_professional_fee: false,
        principal_schedule: "A",
        dependent_schedule: "S"
      )
      conn = post(build_conn(), "/api/v1/plans/get_plan",
      %{
        code: "TEST001",
        tab: "exclusion",
        exclusion: %{
          search_value: "EXC010",
          page_number: 1,
          display_per_page: 5,
          sort_by: "code",
          order_by: "asc"
        },
        pec: %{
          search_value: "PEC0011",
          page_number: 1,
          display_per_page: 5,
          sort_by: "code",
          order_by: "asc"
        }
      })

      assert json_response(conn, 200)["code"] == "TEST001"
    end

    test "with invalid params exclusion tab" do
      conn = post(build_conn(), "/api/v1/plans/get_plan",
      %{
        code: "",
        tab: "exclusion",
        exclusion: %{
          search_value: "EXC010",
          page_number: 1,
          display_per_page: 5,
          sort_by: "code",
          order_by: "asc"
        },
        pec: %{
          search_value: "PEC0011",
          page_number: 1,
          display_per_page: 5,
          sort_by: "code",
          order_by: "asc"
        }
      })

      assert json_response(conn, 400)["errors"]["code"] == "code is invalid"
    end
  end
end

