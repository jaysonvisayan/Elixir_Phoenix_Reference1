defmodule ApiWeb.V1.AccountController do
  use ApiWeb, :controller

  alias Data.Contexts.AccountContext, as: AC
  alias Data.Contexts.ValidationContext, as: VC
  alias Data.Contexts.UtilityContext, as: UC
  alias ApiWeb.{
    AccountView,
    ErrorView
  }

  def create(conn, params) when is_map(params) do
    :create
    |> AC.validate_params(params)
    |> VC.valid_changeset()
    |> AC.generate_account_code()
    |> AC.insert_account(conn)
    |> return_result("account.json", conn)
  end

  def get_accounts(conn, params) when is_map(params) do
      :search
      |> AC.validate_params(params)
      |> VC.valid_changeset()
      |> AC.get_accounts(:search)
      |> return_result("accounts.json", conn)
  end

  def get_accounts(conn, _params), do: return_result({:error_message, "Invalid arguments!"}, "error.json", conn)

  def get_account(conn, params) when is_map(params) do
    :view
    |> AC.validate_params(params)
    |> VC.valid_changeset()
    |> AC.get_account("")
    |> AC.get_account(:profile)
    |> AC.get_account(:addresses)
    |> AC.get_account(:contacts)
    |> AC.get_account(:banks)
    |> AC.get_account(:personnels)
    |> AC.get_account(:plans)
    |> AC.get_account(:approvers)
    |> return_result("view_account.json", conn)
  end

  def get_account(conn, _params), do: return_result({:error_message, "Invalid arguments!"}, "error.json", conn)

  defp return_result({:error_message, message}, _, conn) do
    conn
    |> put_status(412)
    |> put_view(ErrorView)
    |> render("error.json", message: message)
  end

  defp return_result({:error, changeset}, _, conn) do
    conn
    |> put_status(400)
    |> put_view(AccountView)
    |> render("error.json", error: UC.transform_account_error_message(changeset))
  end

  defp return_result([], _json_name, conn) do
    conn
    |> put_status(400)
    |> put_view(AccountView)
    |> render("error.json", error: "No account matched your search.")
  end

  defp return_result(result, json_name, conn) do
    conn
    |> put_status(200)
    |> put_view(AccountView)
    |> render(json_name, result: result)
  end

end
