defmodule ApiWeb.V1.PlanController do
  use ApiWeb, :controller

  alias Data.{
    Contexts.PlanContext,
    Contexts.UtilityContext,
    Contexts.ValidationContext,
    Schemas.Exclusion,
    Schemas.Plan,
    Schemas.PlanPreExistingCondition
  }

  alias ApiWeb.{
    PlanView
  }

  alias ApiWeb.{
    ErrorView
  }


  def get_plans(conn, params) when is_map(params) do
    :search
    |> PlanContext.validate_params(params)
    |> ValidationContext.valid_changeset()
    |> PlanContext.get_plans()
    |> return_result("plans.json", conn)
  end

  def get_plans(conn, _params), do: return_result({:error_message, "Invalid arguments!"}, "error.json", conn)

  def create_plan(conn, params) do
    :create_medical
    |> PlanContext.validate_params(params)
  end

  def get_plan(conn, params) when is_map(params) do
    :view
    |> PlanContext.validate_params(params)
    |> ValidationContext.valid_changeset()
    |> PlanContext.get_plan(:view)
    |> return_result(conn)
  end
  def get_plan(conn, _params), do: return_result({:error_message, "Invalid arguments!"}, "error.json", conn)

  defp return_result({:error, changeset}, _, conn) do
    conn
    |> put_status(400)
    |> put_view(PlanView)
    |> render("error.json", error: UtilityContext.transform_error_message(changeset))
  end

  defp return_result({:error, changeset}, conn) do
    conn
    |> put_status(400)
    |> put_view(PlanView)
    |> render("error.json", error: UtilityContext.transform_error_message(changeset))
  end

  defp return_result([], json_name, conn) do
    conn
    |> put_status(400)
    |> put_view(PlanView)
    |> render(json_name, result: [])
  end

  defp return_result(result, json_name, conn) do
    conn
    |> put_status(200)
    |> put_view(PlanView)
    |> render(json_name, result: result)
  end

  defp return_result({result, json_name}, conn) do
    conn
    |> put_status(200)
    |> put_view(PlanView)
    |> render(json_name, result: result)
  end
end

