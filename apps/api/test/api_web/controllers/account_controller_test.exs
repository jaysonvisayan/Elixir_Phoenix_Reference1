defmodule ApiWeb.AccountControllerTest do
  use ApiWeb.ConnCase

  setup do
    params = %{
      profile_photo: "iVBORw0KGgoAAAANSUhEUgAAAAYAAAAECAIAAAAiZtkUAAAAA3NCSVQICAjb4U/gAAAAGXRFWHRTb2Z0d2FyZQBnbm9tZS1zY3JlZW5zaG907wO/PgAAABVJREFUCJlj/P//PwMqYGLAAMQJAQDengMFOtjosAAAAABJRU5ErkJggg==",
      segment: "C",
      name: "Jollibee Corp",
      type: "H",
      industry: "ADVERTISING",
      effective_date: "Jan-30-2019",
      expiry_date: "Jan-31-2020",
      addresses: [
        %{
          type: "P",
          address_line_1: "CIBI Information Center",
          address_line_2: "Barangay Sta. Cruz",
          city: "Makati City",
          province: "Metro Manila",
          region: "NCR",
          country: "Philippines",
          postal: "1002"
        }
      ],
      address_same_as_billing: false,
      contacts: [
        %{
          type: "CP",
          name: "Juan Dela Cruz",
          department: "Finance",
          designation: "Manager",
          telephone: [
            %{
              area_code: "02",
              number: "1234567",
              local: "808"
            }
          ],
          mobile: [
            %{
              number: "9123456789"
            }
          ],
          fax: [
            %{
              area_code: "02",
              number: "1234567",
              local: "808"
            }
          ],
          email_address: "account_contact@yahoo.com",
          ctc: "1233456678899",
          ctc_date_issued: "Jan-30-2019",
          ctc_place_issued: "Manila",
          passport: "213232132",
          passport_date_issued: "Jan-30-1992",
          passport_place_issued: "DFA Manila"
        }
      ],
      tin: "1223213213",
      vat_status: "20VA",
      previous_carrier: "Previous Carrier",
      attachment_point: "3223",
      banks: [
        %{
          payment_mode: "C",
          payee_name: "Makati Medical Center",
          bank_account: "23213213132",
          bank_name: "Equicom",
          authority_to_debit: false,
          authorization_form: "iVBORw0KGgoAAAANSUhEUgAAAAYAAAAECAIAAAAiZtkUAAAAA3NCSVQICAjb4U/gAAAAGXRFWHRTb2Z0d2FyZQBnbm9tZS1zY3JlZW5zaG907wO/PgAAABVJREFUCJlj/P//PwMqYGLAAMQJAQDengMFOtjosAAAAABJRU5ErkJggg==",
        }
      ],
      bank_same_as_funding: true,
      personnels: [
        %{
          personnel: "Juana Dela Cruz",
          specialization: "Pedia",
          location: "Manila",
          schedule: "2-4",
          no_of_personnel: 2,
          payment_mode: "A",
          retainer_fee: "B",
          amount: "1000.00"
        }
      ]
    }

    insert(:generic_look_up, %{
      code: "A01",
      type: "industry",
      name: "ADVERTISING",
      description: "ADVERTISING"
    })

    insert(:generic_look_up, %{
      code: "C",
      type: "account_segment",
      name: "Corporate",
      description: "Corporate"
    })

    insert(:generic_look_up, %{
      code: "H",
      type: "account_type",
      name: "Headquarters",
      description: "Headquarters"
    })

    insert(:generic_look_up, %{
      code: "20VA",
      type: "vat_status",
      name: "20% VAT-able",
      description: "20% VAT-able"
    })

    insert(:generic_look_up, %{
      code: "P",
      type: "address_type",
      name: "Permanent",
      description: "Permanent"
    })

    insert(:generic_look_up, %{
      code: "CP",
      type: "account_contact_type",
      name: "Contact Person",
      description: "Contact Person"
    })

    insert(:generic_look_up, %{
      code: "C",
      type: "bank_payment_mode",
      name: "Check",
      description: "Check"
    })

    insert(:generic_look_up, %{
      code: "A",
      type: "account_personnel_payment_mode",
      name: "Annual",
      description: "Annual"
    })

    insert(:generic_look_up, %{
      code: "B",
      type: "retainer_fee",
      name: "Built-in",
      description: "Built-in"
    })

    insert(:address_look_up, %{
      region: "NCR",
      region_name: "",
      province: "Metro Manila",
      city_municipal: "Makati City"
    })

    {:ok, %{
      params: params
    }}
  end

  describe "search accounts" do
    test "with valid params" do
      {:ok, eff_date} = Date.new(2011, 1, 1)
      {:ok, exp_date} = Date.new(2050, 1, 1)
      account = insert(:account, code: "1",
                       name: "asd",
                       segment: "Corporation",
                       effective_date: eff_date,
                       expiry_date: exp_date,
                       status: "active"
      )
      conn = post(build_conn(), "/api/v1/accounts/get_accounts", %{page_number: 1, search_value: "", display_per_page: "5", sort_by: "code", order_by: "desc"})
      assert List.first(json_response(conn, 200)["accounts"])["code"] == account.code
    end

    test "with invalid params/400" do
      {:ok, eff_date} = Date.new(2011, 1, 1)
      {:ok, exp_date} = Date.new(2050, 1, 1)
      insert(:account, code: "1",
                       name: "asd",
                       segment: "Corporation",
                       effective_date: eff_date,
                       expiry_date: exp_date,
                       status: "active"
      )
      conn = post(build_conn(), "/api/v1/accounts/get_accounts", %{page_number: 1, search_value: "", display_per_page: "", sort_by: "code", order_by: "asc"})
      assert json_response(conn, 400)["errors"]["display_per_page"] == "is required"
    end

    test "with no results found" do
      {:ok, eff_date} = Date.new(2011, 1, 1)
      {:ok, exp_date} = Date.new(2050, 1, 1)
      insert(:account, code: "1",
                       name: "asd",
                       segment: "Corporation",
                       effective_date: eff_date,
                       expiry_date: exp_date,
                       status: "active"
      )
      conn = post(build_conn(), "/api/v1/accounts/get_accounts", %{page_number: 1, search_value: "hahahahaha", display_per_page: "5", sort_by: "code", order_by: "desc"})
      assert json_response(conn, 400)["errors"] == "No account matched your search."
    end
  end

  describe "create accounts" do
    test "with valid params", %{params: params} do
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 200
      assert json_response(conn, 200)["name"] == params[:name]
    end

    test "with invalid profile photo", %{params: params} do
      params =
        params
        |> Map.put(:profile_photo, 123)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["profile_photo"] == "Invalid profile photo"
    end

    test "with invalid profile photo image format", %{params: params} do
      params =
        params
        |> Map.put(:profile_photo, "IiI=")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["profile_photo"] == "Invalid profile photo"
    end

    test "with missing segment", %{params: params} do
      params =
        params
        |> Map.delete(:segment)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["segment"] == "Enter segment"
    end

    test "with invalid segment", %{params: params} do
      params =
        params
        |> Map.put(:segment, "ABC")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["segment"] == "Invalid segment"
    end

    test "with missing name", %{params: params} do
      params =
        params
        |> Map.delete(:name)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["name"] == "Enter name"
    end

    test "with invalid name", %{params: params} do
      params =
        params
        |> Map.put(:name, 123)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["name"] == "Invalid name"
    end

    test "with invalid name length", %{params: params} do
      params =
        params
        |> Map.put(:name, generate_data(81))
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["name"] == "Only 80 alphanumeric characters are allowed"
    end

    test "with missing account type", %{params: params} do
      params =
        params
        |> Map.delete(:type)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["type"] == "Enter type"
    end

    test "with invalid type", %{params: params} do
      params =
        params
        |> Map.put(:type, "ABC")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["type"] == "Invalid type"
    end

    test "with missing industry", %{params: params} do
      params =
        params
        |> Map.delete(:industry)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["industry"] == "Enter industry"
    end

    test "with invalid industry", %{params: params} do
      params =
        params
        |> Map.put(:industry, "ABC")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["industry"] == "Invalid industry"
    end

    test "with missing effective date", %{params: params} do
      params =
        params
        |> Map.delete(:effective_date)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["effective_date"] == "Enter effective date"
    end

    test "with invalid effective date", %{params: params} do
      params =
        params
        |> Map.put(:effective_date, "ABC")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["effective_date"] == "Invalid effective date"
    end

    test "with missing expiry date", %{params: params} do
      params =
        params
        |> Map.delete(:expiry_date)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["expiry_date"] == "Enter expiry date"
    end

    test "with invalid expiry date", %{params: params} do
      params =
        params
        |> Map.put(:expiry_date, "ABC")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["expiry_date"] == "Invalid expiry date"
    end

    test "with effective date not future date", %{params: params} do
      params =
        params
        |> Map.put(:effective_date, "Jan-01-1999")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["effective_date"] == "must be future dated"
    end

    test "with effective date greater than expiry date", %{params: params} do
      params =
        params
        |> Map.put(:effective_date, "Jan-01-2999")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["expiry_date"] == "must be greater than effective date"
    end

    test "with missing address", %{params: params} do
      params =
        params
        |> Map.delete(:addresses)
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "Enter at least one address"
    end

    test "with invalid address format", %{params: params} do
      params =
        params
        |> Map.put(:addresses, "ABC")
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "Invalid addresses"
    end

    test "with missing type in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.delete(:type)
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (type: Enter type)"
    end

    test "with invalid type in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.put(:type, "ABC")
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (type: Invalid type)"
    end

    test "with missing address line 1 in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.delete(:address_line_1)
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (address_line_1: Enter address line 1)"
    end

    test "with invalid address line 1 in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.put(:address_line_1, generate_data(151))
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (address_line_1: Only 150 alphanumeric characters are allowed)"
    end

    test "with missing address line 2 in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.delete(:address_line_2)
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (address_line_2: Enter address line 2)"
    end

    test "with invalid address line 2 in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.put(:address_line_2, generate_data(151))
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (address_line_2: Only 150 alphanumeric characters are allowed)"
    end

    test "with missing city in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.delete(:city)
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (city: Enter city)"
    end

    test "with invalid city in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.put(:city, "ABC")
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (city: Invalid city)"
    end

    test "with missing province in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.delete(:province)
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (province: Enter province)"
    end

    test "with invalid province in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.put(:province, "ABC")
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (province: Invalid province)"
    end

    test "with missing region in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.delete(:region)
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (region: Enter region)"
    end

    test "with invalid region in addresses", %{params: params} do
      address_params =
        params[:addresses]
        |> Enum.at(0)
        |> Map.put(:region, "ABC")
      params =
        params
        |> Map.put(:addresses, [address_params])
      conn = post(build_conn(), "/api/v1/accounts/create_account", params)
      assert conn.status == 400
      assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (region: Invalid region)"
    end
  end

  test "with missing city in addresses", %{params: params} do
    address_params =
      params[:addresses]
      |> Enum.at(0)
      |> Map.delete(:city)
    params =
      params
      |> Map.put(:addresses, [address_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (city: Enter city)"
  end

  test "with invalid city in addresses", %{params: params} do
    address_params =
      params[:addresses]
      |> Enum.at(0)
      |> Map.put(:city, "ABC")
    params =
      params
      |> Map.put(:addresses, [address_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (city: Invalid city)"
  end

  test "with missing country in addresses", %{params: params} do
    address_params =
      params[:addresses]
      |> Enum.at(0)
      |> Map.delete(:country)
    params =
      params
      |> Map.put(:addresses, [address_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (country: Enter country)"
  end

  test "with invalid country in addresses", %{params: params} do
    address_params =
      params[:addresses]
      |> Enum.at(0)
      |> Map.put(:country, "ABC")
    params =
      params
      |> Map.put(:addresses, [address_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (country: Invalid country)"
  end

  test "with missing postal in addresses", %{params: params} do
    address_params =
      params[:addresses]
      |> Enum.at(0)
      |> Map.delete(:postal)
    params =
      params
      |> Map.put(:addresses, [address_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (postal: Enter postal)"
  end

  test "with invalid postal in addresses", %{params: params} do
    address_params =
      params[:addresses]
      |> Enum.at(0)
      |> Map.put(:postal, "123456")
    params =
      params
      |> Map.put(:addresses, [address_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["addresses"] == "row 1 errors (postal: Only 5 numeric characters are allowed)"
  end

  test "with missing address same as billing", %{params: params} do
    params =
      params
      |> Map.delete(:address_same_as_billing)
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["address_same_as_billing"] == "Enter address same as billing"
  end

  test "with invalid address same as billing", %{params: params} do
    params =
      params
      |> Map.put(:address_same_as_billing, "ABC")
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["address_same_as_billing"] == "Invalid address same as billing"
  end

  test "with missing type in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.delete(:type)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (type: Enter type)"
  end

  test "with invalid type in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:type, "ABC")
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (type: Invalid type)"
  end

  test "with missing name in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.delete(:name)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (name: Enter name)"
  end

  test "with invalid name in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:name, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (name: Invalid name)"
  end

  test "with invalid name length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:name, generate_data(81))
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (name: Only 80 alphanumeric characters are allowed)"
  end

  test "with missing department in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.delete(:department)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (department: Enter department)"
  end

  test "with invalid department in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:department, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (department: Invalid department)"
  end

  test "with invalid department length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:department, generate_data(81))
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (department: Only 80 alphanumeric characters are allowed)"
  end

  test "with missing designation in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.delete(:designation)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (designation: Enter designation)"
  end

  test "with invalid designation in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:designation, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (designation: Invalid designation)"
  end

  test "with invalid designation length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:designation, generate_data(81))
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (designation: Only 80 alphanumeric characters are allowed)"
  end

  test "with invalid telephone in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:telephone, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (telephone: Invalid telephone)"
  end

  test "with invalid telephone area code in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:telephone, [%{
        area_code: 1,
        number: "1234567",
        local: "123"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (area_code: Invalid area code))"
  end

  test "with invalid telephone area code length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:telephone, [%{
        area_code: "1234567",
        number: "1234567",
        local: "123"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (area_code: Only 6 numeric characters are allowed))"
  end

  test "with invalid telephone number in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:telephone, [%{
        area_code: "123456",
        number: 1,
        local: "123"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (number: Invalid number))"
  end

  test "with invalid telephone number length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:telephone, [%{
        area_code: "123456",
        number: "12345678",
        local: "123"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (number: Only 7 numeric characters are allowed))"
  end

  test "with invalid telephone local in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:telephone, [%{
        area_code: "123456",
        number: "1234567",
        local: 1
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (local: Invalid local))"
  end

  test "with invalid telephone local length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:telephone, [%{
        area_code: "123456",
        number: "1234567",
        local: "1234"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (local: Only 3 numeric characters are allowed))"
  end

  test "with missing mobile in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.delete(:mobile)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (mobile: Enter mobile)"
  end

  test "with invalid mobile in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:mobile, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (mobile: Invalid mobile)"
  end

  test "with invalid mobile number in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:mobile, [%{
        number: 1,
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (number: Invalid number))"
  end

  test "with invalid mobile number length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:mobile, [%{
        number: "12345678910",
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (number: Only 10 numeric characters are allowed))"
  end

  test "with invalid fax in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:fax, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (fax: Invalid fax)"
  end

  test "with invalid fax area code in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:fax, [%{
        area_code: 1,
        number: "1234567",
        local: "123"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (area_code: Invalid area code))"
  end

  test "with invalid fax area code length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:fax, [%{
        area_code: "1234567",
        number: "1234567",
        local: "123"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (area_code: Only 6 numeric characters are allowed))"
  end

  test "with invalid fax number in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:fax, [%{
        area_code: "123456",
        number: 1,
        local: "123"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (number: Invalid number))"
  end

  test "with invalid fax number length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:fax, [%{
        area_code: "123456",
        number: "12345678",
        local: "123"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (number: Only 7 numeric characters are allowed))"
  end

  test "with invalid fax local in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:fax, [%{
        area_code: "123456",
        number: "1234567",
        local: 1
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (local: Invalid local))"
  end

  test "with invalid fax local length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:fax, [%{
        area_code: "123456",
        number: "1234567",
        local: "1234"
      }])
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (contacts: row 1 errors (local: Only 3 numeric characters are allowed))"
  end

  test "with missing email_address format in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.delete(:email_address)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (email_address: Enter email address)"
  end

  test "with invalid email_address in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:email_address, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (email_address: Invalid email address)"
  end

  test "with invalid email_address format in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:email_address, "123")
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (email_address: Invalid email address)"
  end

  test "with invalid ctc in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:ctc, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (ctc: Invalid ctc)"
  end

  test "with invalid ctc length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:ctc, generate_data(81))
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (ctc: Only 80 alphanumeric characters are allowed)"
  end

  test "with invalid ctc place issued in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:ctc_place_issued, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (ctc_place_issued: Invalid ctc place issued)"
  end

  test "with invalid ctc_place_issued length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:ctc_place_issued, generate_data(81))
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (ctc_place_issued: Only 80 alphanumeric characters are allowed)"
  end

  test "with invalid ctc date issued in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:ctc_date_issued, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (ctc_date_issued: Invalid ctc date issued)"
  end

  test "with invalid passport in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:passport, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (passport: Invalid passport)"
  end

  test "with invalid passport length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:passport, generate_data(81))
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (passport: Only 80 alphanumeric characters are allowed)"
  end

  test "with invalid passport place issued in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:passport_place_issued, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (passport_place_issued: Invalid passport place issued)"
  end

  test "with invalid passport place issued length in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:passport_place_issued, generate_data(81))
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (passport_place_issued: Only 80 alphanumeric characters are allowed)"
  end

  test "with invalid passport date issued in contacts", %{params: params} do
    contact_params =
      params[:contacts]
      |> Enum.at(0)
      |> Map.put(:passport_date_issued, 123)
    params =
      params
      |> Map.put(:contacts, [contact_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["contacts"] == "row 1 errors (passport_date_issued: Invalid passport date issued)"
  end

  test "with missing tin", %{params: params} do
    params =
      params
      |> Map.delete(:tin)
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["tin"] == "Enter tin"
  end

  test "with invalid tin", %{params: params} do
    params =
      params
      |> Map.put(:tin, 1)
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["tin"] == "Invalid tin"
  end

  test "with invalid tin length", %{params: params} do
    params =
      params
      |> Map.put(:tin, generate_data(13))
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["tin"] == "Only 12 numeric characters are allowed"
  end

  test "with missing vat status", %{params: params} do
    params =
      params
      |> Map.delete(:vat_status)
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["vat_status"] == "Enter vat status"
  end

  test "with invalid vat status", %{params: params} do
    params =
      params
      |> Map.put(:vat_status, "ABC")
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["vat_status"] == "Invalid vat status"
  end

  test "with invalid previous carrier", %{params: params} do
    params =
      params
      |> Map.put(:previous_carrier, 1)
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["previous_carrier"] == "Invalid previous carrier"
  end

  test "with invalid previous carrier length", %{params: params} do
    params =
      params
      |> Map.put(:previous_carrier, generate_data(81))
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["previous_carrier"] == "Only 80 alphanumeric characters are allowed"
  end

  test "with invalid attachment point", %{params: params} do
    params =
      params
      |> Map.put(:attachment_point, "ABC")
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["attachment_point"] == "Invalid attachment point"
  end

  test "with invalid attachment point length", %{params: params} do
    params =
      params
      |> Map.put(:attachment_point, 1_234_567_898_765)
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["attachment_point"] == "Only 12 numeric characters are allowed"
  end

  test "with missing bank same as funding", %{params: params} do
    params =
      params
      |> Map.delete(:bank_same_as_funding)
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["bank_same_as_funding"] == "Enter bank same as funding"
  end

  test "with invalid bank same as funding", %{params: params} do
    params =
      params
      |> Map.put(:bank_same_as_funding, "ABC")
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["bank_same_as_funding"] == "Invalid bank same as funding"
  end

  test "with missing payment mode in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.delete(:payment_mode)
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (payment_mode: Enter payment mode)"
  end

  test "with invalid payment mode in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:payment_mode, "ABC")
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (payment_mode: Invalid payment mode)"
  end

  test "with invalid payee name in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:payee_name, 123)
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (payee_name: Invalid payee name)"
  end

  test "with invalid payee name length in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:payee_name, generate_data(81))
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (payee_name: Only 80 alphanumeric characters are allowed)"
  end

  test "with invalid bank account in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:bank_account, 123)
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (bank_account: Invalid bank account)"
  end

  test "with invalid bank account length in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:bank_account, generate_data(13))
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (bank_account: Only 12 numeric characters are allowed)"
  end

  test "with invalid bank name in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:bank_name, 123)
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (bank_name: Invalid bank name)"
  end

  test "with invalid bank name length in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:bank_name, generate_data(81))
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (bank_name: Only 80 alphanumeric characters are allowed)"
  end

  test "with invalid bank branch in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:bank_branch, 123)
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (bank_branch: Invalid bank branch)"
  end

  test "with invalid bank branch length in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:bank_branch, generate_data(81))
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (bank_branch: Only 80 alphanumeric characters are allowed)"
  end

  test "with invalid authority to debit in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:authority_to_debit, 123)
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (authority_to_debit: Invalid authority to debit)"
  end

  test "with invalid authorization form in banks", %{params: params} do
    bank_params =
      params[:banks]
      |> Enum.at(0)
      |> Map.put(:authorization_form, 123)
    params =
      params
      |> Map.put(:banks, [bank_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["banks"] == "row 1 errors (authorization_form: Invalid authorization form)"
  end

  test "with missing personnel in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.delete(:personnel)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (personnel: Enter personnel)"
  end

  test "with invalid personnel in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:personnel, 123)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (personnel: Invalid personnel)"
  end

  test "with invalid personnel length in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:personnel, generate_data(81))
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (personnel: Only 80 alphanumeric characters are allowed)"
  end

  test "with missing specialization in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.delete(:specialization)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (specialization: Enter specialization)"
  end

  test "with invalid specialization in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:specialization, 123)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (specialization: Invalid specialization)"
  end

  test "with invalid specialization length in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:specialization, generate_data(81))
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (specialization: Only 80 alphanumeric characters are allowed)"
  end

  test "with missing location in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.delete(:location)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (location: Enter location)"
  end

  test "with invalid location in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:location, 123)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (location: Invalid location)"
  end

  test "with invalid location length in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:location, generate_data(81))
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (location: Only 80 alphanumeric characters are allowed)"
  end

  test "with missing schedule in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.delete(:schedule)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (schedule: Enter schedule)"
  end

  test "with invalid schedule in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:schedule, 123)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (schedule: Invalid schedule)"
  end

  test "with invalid schedule length in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:schedule, generate_data(81))
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (schedule: Only 80 alphanumeric characters are allowed)"
  end

  test "with missing payment mode in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.delete(:payment_mode)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (payment_mode: Enter payment mode)"
  end

  test "with invalid payment mode in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:payment_mode, "ABC")
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (payment_mode: Invalid payment mode)"
  end

  test "with missing retainer fee in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.delete(:retainer_fee)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (retainer_fee: Enter retainer fee)"
  end

  test "with invalid retainer fee in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:retainer_fee, "ABC")
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (retainer_fee: Invalid retainer fee)"
  end

  test "with missing amount in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.delete(:amount)
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (amount: Enter amount)"
  end

  test "with invalid amount in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:amount, "ABC")
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (amount: Invalid amount)"
  end

  test "with invalid amount length in personnels", %{params: params} do
    personnel_params =
      params[:personnels]
      |> Enum.at(0)
      |> Map.put(:amount, "123456789.00")
    params =
      params
      |> Map.put(:personnels, [personnel_params])
    conn = post(build_conn(), "/api/v1/accounts/create_account", params)
    assert conn.status == 400
    assert json_response(conn, 400)["errors"]["personnels"] == "row 1 errors (amount: Only 8 numeric characters are allowed)"
  end

  defp generate_data(range) do
    range..range
    |> Faker.Lorem.characters()
    |> to_string()
  end
end
