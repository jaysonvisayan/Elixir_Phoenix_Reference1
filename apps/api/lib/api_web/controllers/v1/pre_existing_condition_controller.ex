defmodule ApiWeb.V1.PreExistingConditionController do
  use ApiWeb, :controller
  @moduledoc false

  alias Data.Contexts.PreExistingConditionContext, as: PECC
  alias Data.Contexts.ValidationContext, as: VC
  alias Data.Contexts.UtilityContext, as: UC

  alias ApiWeb.ErrorView
  alias ApiWeb.V1.{
    PreExistingConditionView
  }

  def create_pre_existing_condition(conn, params) do
    :create
    |> PECC.validate_params(params)
    |> PECC.insert_pre_existing_condition(params)
    |> return_result("pec.json", conn)
  end

  def get_pre_existing_conditions(conn, params) when is_map(params) do
    :search
    |> PECC.validate_params(params)
    |> VC.valid_changeset()
    |> PECC.get_pre_existing_conditions(:search)
    |> return_result("pre-existing_conditions.json", conn)
  end

  defp return_result({:error_message, message}, _, conn) do
    conn
    |> put_status(412)
    |> put_view(ErrorView)
    |> render("error.json", message: message)
  end

  defp return_result({:error, changeset}, _, conn) do
    conn
    |> put_status(400)
    |> put_view(PreExistingConditionView)
    |> render("error.json", error: UC.transform_error_message(changeset))
  end

  defp return_result([], _json_name, conn) do
    conn
    |> put_status(400)
    |> put_view(PreExistingConditionView)
    |> render("error.json", error: "No pre-existing condition matched your search.")
  end

  defp return_result({:ok, result}, json_name, conn) do
    conn
    |> put_status(200)
    |> put_view(PreExistingConditionView)
    |> render(json_name, result: result)
  end

  defp return_result(result, json_name, conn) do
    conn
    |> put_status(200)
    |> put_view(PreExistingConditionView)
    |> render(json_name, result: result)
  end

  def get_pre_existing_condition(conn, %{"code" => ""}), do: return_result({:error_message, "Invalid arguments!"}, "error.json", conn)

  def get_pre_existing_condition(conn, params) when is_map(params) do
    :view
    |> PECC.validate_params(params)
    |> VC.valid_changeset()
    |> PECC.get_pre_existing_condition(:view)
    |> return_result("pec.json", conn)
  end

end

