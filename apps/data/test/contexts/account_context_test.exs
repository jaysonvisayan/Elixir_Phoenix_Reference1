defmodule Data.Contexts.AccountContextTest do
  use Data.SchemaCase, async: false

  alias Data.{
    Contexts.AccountContext
  }

  describe "view an account" do
    test "check if parameters valid returns valid parameters" do
      insert(:account, code: "test")
      params = %{
        code: "test",
        tab: "approvers"
      }

      {is_valid, changeset} = AccountContext.validate_params(:view, params)

      assert is_valid == true
      assert changeset.changes.code == params.code
    end

    test "by approver tab with valid params returns valid data" do
      insert(:account, name: "test", code: "test")
      approver1 = insert(:account_approver, account_code: "test", name: "1")
      approver2 = insert(:account_approver, account_code: "test", name: "2")
      approver3 = insert(:account_approver, account_code: "test", name: "3")

      params = %{
        code: "test",
        tab: "approvers"
      }

      account = AccountContext.get_account(params, :approvers)

      assert Enum.at(account.result.approvers, 0).name == approver1.name
      assert Enum.at(account.result.approvers, 1).name == approver2.name
      assert Enum.at(account.result.approvers, 2).name == approver3.name
      assert account.code == params.code
    end

    test "by approver tab with valid params returns no data found" do
      insert(:account, name: "test", code: "test")

      params = %{
        code: "test",
        tab: "approvers"
      }

      account = AccountContext.get_account(params, :approvers)

      assert account.code == params.code
      assert account.result.approvers == []
    end

    test "by approver tab with valid params returns nil" do
      params = %{
        code: "test",
        tab: "approvers"
      }

      account = AccountContext.get_account(params, :approvers)
      assert account == nil
    end

    test "by profile tab with valid params returns valid data" do
      account = insert(:account, name: "test", code: "test")
      params = %{
        code: "test",
        tab: "profile"
      }

      result = AccountContext.get_account(params, :profile)

      assert result.code == account.code
      assert result.code == params.code
    end

    test "by profile tab with valid params returns no data found" do
      params = %{
        code: "test",
        tab: "approvers"
      }

      account = AccountContext.get_account(params, :approvers)
      assert account == nil
    end

    test "validate parameters returns validate required error" do
      params = %{
        code: Faker.Code.iban()
      }

      {is_valid, changeset} = AccountContext.validate_params(:view, params)

      assert is_valid == false
      assert changeset.errors == [code: {"does not exists", []}, tab: {"is required", [validation: :required]}]
    end
  end
end
