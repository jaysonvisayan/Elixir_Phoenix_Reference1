defmodule ApiWeb.V1.BenefitController do
  use ApiWeb, :controller
  @moduledoc false

  alias Data.Contexts.BenefitContext, as: BC
  alias Data.Contexts.ValidationContext, as: VC
  alias Data.Contexts.UtilityContext, as: UC

  alias ApiWeb.{
    BenefitView,
    ErrorView
  }

  def get_benefits(conn, params) when is_map(params) do
    :search
    |> BC.validate_params(params)
    |> VC.valid_changeset()
    |> BC.get_benefits(:search)
    |> return_result("benefits.json", conn)
  end

  def get_benefit_acu(conn, params) when is_map(params) do
    :view
    |> BC.validate_params(params)
    |> VC.valid_changeset()
    |> BC.get_benefit_acu(:view)
    |> return_result("benefit_acu.json", conn)
  end

  def create_benefit_acu(conn, params) do
    :create
    |> BC.validate_params(params)
    |> VC.valid_changeset()
    |> BC.insert_benefit_acu()
    |> BC.insert_benefit_limit()
    |> return_result("acu_benefit.json", conn)
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
    |> put_view(BenefitView)
    |> render("error.json", error: UC.transform_error_message(changeset))
  end

  defp return_result([], _json_name, conn) do
    conn
    |> put_status(400)
    |> put_view(BenefitView)
    |> render("error.json", error: "No benefits matched your search")
  end

  defp return_result(nil, _json_name, conn) do
    conn
    |> put_status(400)
    |> put_view(BenefitView)
    |> render("error.json", error: "No benefits matched your search")
  end

  defp return_result(result, json_name, conn) do
    conn
    |> put_status(200)
    |> put_view(BenefitView)
    |> render(json_name, result: result)
  end

end
