defmodule ApiWeb.ExclusionControllerTest do
  use ApiWeb.ConnCase

  describe "get_exclusions" do
    test "with valid params" do
      exclusions = insert(:exclusion,
                          code: "1",
                          name: "exclusion_test",
                          type: "General Exclusion",
                          updated_at: DateTime.utc_now(),
                          version: "1"
      )
      conn = post(
        build_conn(),
        "/api/v1/exclusions/get_exclusions",
        %{
          page_number: 1,
          search_value: "",
          display_per_page: "5",
          sort_by: "code",
          order_by: "desc"
        }
      )
      assert List.first(json_response(conn, 200)["exclusions"])["code"] =~ exclusions.code
    end

    test "with invalid params/400" do
      insert(:exclusion, code: "1")
      conn = post(
        build_conn(),
        "/api/v1/exclusions/get_exclusions",
        %{
          page_number: 1,
          search_value: "",
          display_per_page: "",
          sort_by: "code",
          order_by: "asc"
        }
      )
      assert json_response(conn, 400)["errors"]["display_per_page"] == "Enter display_per_page"
    end

  end

  describe "get exclusion" do
    test "with valid params" do
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      e = insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "icd/cpt based",
             classification: "Standard",
             diagnoses: ["A01.1"],
             procedures: ["801234"]
      )
      conn = post(build_conn(), "api/v1/exclusions/get_exclusion",
                             %{
                               code: "GENEX1",
                               diagnosis: %{
                                 search_value: "A01.1",
                                 page_number: 1,
                                 display_per_page: 5,
                                 sort_by: "code",
                                 order_by: "asc"
                               },
                               procedure: %{
                                 search_value: "",
                                 page_number: 1,
                                 display_per_page: 5,
                                 sort_by: "code",
                                 order_by: "asc"
                               }
                             })
      assert json_response(conn, 200)["code"] == e.code
    end

    # test "with invalid params" do
    #   insert(:diagnosis, code: "A01.1",
    #                      desc: Faker.Lorem.sentence(5, ".")
    #   )
    #   insert(:diagnosis, code: "A01.0",
    #                      desc: Faker.Lorem.sentence(5, ".")
    #   )
    #   insert(:procedure, code: "801234",
    #                      desc: Faker.Lorem.sentence(5, ".")
    #   )
    #   insert(:exclusion,
    #          code: "GENEX1",
    #          name: Faker.Name.title(),
    #          type: "icd/cpt based",
    #          classification: "Standard",
    #          diagnoses: ["A01.1"],
    #          procedures: ["801234"]
    #   )
    #   conn = post(build_conn(), "api/v1/exclusions/get_exclusion",
    #                          %{
    #                            code: "GENEX1",
    #                            diagnosis: %{
    #                              search_value: "sampleinvalid",
    #                              page_number: 1,
    #                              display_per_page: 5,
    #                              sort_by: "code",
    #                              order_by: "asc"
    #                            },
    #                            procedure: %{
    #                              search_value: "801234asdasda",
    #                              page_number: 1,
    #                              display_per_page: 5,
    #                              sort_by: "code",
    #                              order_by: "asc"
    #                            }
    #                          })
    #   assert json_response(conn, 400)["errors"] == "code entered is invalid"
    # end
  end

  describe "create exclusion" do
    test "with valid params" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "456",
        name: "456",
        type: "policy",
        diagnoses: ["a01.1", "A01.0"],
        procedures: ["80123"],
        policies: ["asdasd"],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 200)["code"] == params.code
    end

    test "with code already taken" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "GENEX1",
        name: "456",
        type: "policy",
        diagnoses: ["a01.1", "A01.0"],
        procedures: ["80123"],
        policies: ["asdasd"],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 400)["errors"]["code"] == "code is already taken"
    end

    test "with blank code" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "",
        name: "456",
        type: "policy",
        diagnoses: ["a01.1", "A01.0"],
        procedures: ["80123"],
        policies: ["asdasd"],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 400)["errors"]["code"] == "Enter code"
    end

    test "with random type" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: Faker.Name.title(),
        diagnoses: ["a01.1", "A01.0"],
        procedures: ["80123"],
        policies: ["asdasd"],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 400)["errors"]["type"] == "type select exclusion type"
    end

    test "with policy type and empty list" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: "Policy",
        diagnoses: ["a01.1", "A01.0"],
        procedures: ["80123"],
        policies: [],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 400)["errors"]["type"] == "type Add at least one policy"
    end

    test "with icd/cpt based type and empty list" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: "ICD/CPT based",
        diagnoses: [],
        procedures: [],
        policies: [""],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 400)["errors"]["type"] == "type Add at least one diagnosis or procedure"
    end

    test "with icd/cpt based type and invalid diagnosis code" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: "ICD/CPT based",
        diagnoses: ["JAHAHA"],
        procedures: [],
        policies: [],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 400)["errors"]["diagnoses"] == "diagnoses jahaha does not exist"
    end

    test "with icd/cpt based type and invalid procedure code" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: "ICD/CPT based",
        diagnoses: [],
        procedures: ["HEHEHE"],
        policies: [],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 400)["errors"]["procedures"] == "procedures hehehe does not exist"
    end

    test "with invalid classification type" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: "ICD/CPT based",
        diagnoses: [],
        procedures: ["801234"],
        policies: [],
        classification: "hehe"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 400)["errors"]["classification"] == "classification select classification type"
    end

    test "with valid params icd/diagnoses" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: "ICD/CPT based",
        diagnoses: ["A01.1", "A01.0"],
        procedures: [],
        policies: [],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 200)["code"] == params.code
    end

    test "with valid params icd/procedures" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234a",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: "ICD/CPT based",
        diagnoses: [],
        procedures: ["801234A"],
        policies: ["asdasda"],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 200)["code"] == params.code
    end

    test "with valid params policy" do
      insert(:exclusion,
             code: "GENEX1",
             name: Faker.Name.title(),
             type: "Policy",
             classification: "Standard"
      )
      insert(:diagnosis, code: "A01.1",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:diagnosis, code: "A01.0",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      insert(:procedure, code: "801234",
                         desc: Faker.Lorem.sentence(5, ".")
      )
      params = %{
        code: "123",
        name: "456",
        type: "policy",
        policies: ["asdasd"],
        classification: "Standard"
      }
      conn = post(build_conn(), "/api/v1/exclusions/create_exclusions", params)
      assert json_response(conn, 200)["code"] == params.code
    end
  end

  describe "get pec" do
    test "with valid params" do
      insert(:pre_existing_conditions, code: "sample1")
      conn = post(build_conn(), "api/v1/pec/get_pre-existing_condition",
        %{
          code: "sample1",
          name: "sample1",
          type: "policy",
          diagnoses: ["a01.1", "A01.0"],
          procedures: ["80123"],
          policies: ["asdasd"],
          classification: "Standard"
        })
      assert json_response(conn, 200)["code"] == "sample1"
    end


    test "with invalid params/400" do
      insert(:pre_existing_conditions, code: "codetest")
      conn = post(build_conn(), "api/v1/pec/get_pre-existing_condition",
        %{
          code: "sfsdfg"
        })
      assert json_response(conn, 412)["errors"]["code"] == nil
    end
  end
end

