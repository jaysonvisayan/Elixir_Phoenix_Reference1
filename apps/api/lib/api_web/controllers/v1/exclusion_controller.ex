defmodule ApiWeb.V1.ExclusionController do
  use ApiWeb, :controller
  @moduledoc false

  alias Data.Contexts.ExclusionContext, as: EC
  alias Data.Contexts.ValidationContext, as: VC
  alias Data.Contexts.UtilityContext, as: UC

  alias ApiWeb.{
    ErrorView,
    ExclusionView
  }

  def get_exclusions(conn, params) when is_map(params) do
    :search
    |> EC.validate_params(params)
    |> VC.valid_changeset()
    |> EC.get_exclusions(:search)
    |> return_result("search_exclusions.json", conn)
  end

  def get_exclusions(conn, _params), do: return_result({:error_message, "Invalid arguments"}, "error.json", conn)

  def create_exclusion(conn, params) when is_map(params) do
    :create
    |> EC.validate_params(params)
    |> VC.valid_changeset()
    |> EC.insert_exclusion()
    |> return_result("exclusion.json", conn)
  end

  def create_exclusion(conn, _params), do: return_result({:error_message, "Invalid arguments!"}, "error.json", conn)

  def get_exclusion(conn, params) when is_map(params) do
    :view
    |> EC.validate_params(params)
    |> VC.valid_changeset()
    |> EC.get_exclusion(:view)
    |> return_result("view_exclusion.json", conn)
  end

  def get_exclusion(conn, _params), do: return_result({:error_message, "Invalid arguments!"}, "error.json", conn)

  def return_result({:error_message, message}, _, conn) do
    conn
    |> put_status(412)
    |> put_view(ErrorView)
    |> render("error.json", message: message)
  end

  def return_result({:error, changeset}, _, conn) do
    conn
    |> put_status(400)
    |> put_view(ExclusionView)
    |> render("error.json", error: UC.transform_error_message(changeset))
  end

  def return_result(nil, _json_name, conn) do
    conn
    |> put_status(400)
    |> put_view(ExclusionView)
    |> render("error.json", error: "No Exclusion matched your search")
  end
  def return_result(result, json_name, conn) do
    conn
    |> put_status(200)
    |> put_view(ExclusionView)
    |> render(json_name, result: result)
  end
end
