defmodule ApiWeb.BenefitView do
  use ApiWeb, :view

  @moduledoc false

  def render("benefits.json", %{result: benefits}) do
    %{
      benefits: benefits
    }
  end

  def render("benefit_acu.json", %{result: benefits}) do
    %{
      code: benefits.code,
      name: benefits.name,
      category: benefits.category,
      is_loa_facilitated: benefits.is_loa_facilitated,
      is_reimbursement: benefits.is_reimbursement,
      is_hospital: benefits.is_hospital,
      is_clinic: benefits.is_clinic,
      is_mobile: benefits.is_mobile,
      acu_type: benefits.acu_type,
      acu_type_coverage: benefits.acu_type_coverage,
      # limit: benefits.limit,
      # limit_amount: benefits.limit_amount,
      # risk_share: benefits.risk_share,
      risk_share_amount: benefits.risk_share_amount,
      # member_pays_handling: benefits.member_pays_handling,
      is_reimbursement: benefits.is_reimbursement,
      updated_by: benefits.updated_by,
      updated_at: benefits.updated_at,
      packages: benefits.packages,
      limit:  render_many(
        benefits.benefit_limits,
        ApiWeb.BenefitView,
        "benefit_limits.json",
        as: :limit
      )
    }
  end

  def render("error.json", %{error: error}) do
    %{
      errors: error
    }
  end

  def render("acu_benefit.json",  %{result: benefit}) do
    %{
      code: benefit.code,
      name: benefit.name,
      type: benefit.type,
      category: benefit.category,
      acu_type: benefit.acu_type,
      acu_type_coverage: benefit.acu_type_coverage,
      risk_share_type: benefit.risk_share,
      member_pays_handling: benefit.member_pays_handling,
      is_loa_facilitated: benefit.is_loa_facilitated,
      is_reimbursement: benefit.is_reimbursement,
      is_hospital: benefit.is_hospital,
      is_clinic: benefit.is_clinic,
      is_mobile: benefit.is_mobile,
      risk_share_amount: benefit.risk_share_amount,
      packages: benefit.packages,
      limit:  render_many(
        benefit.benefit_limits,
        ApiWeb.BenefitView,
        "benefit_limits.json",
        as: :limit
      )
    }
  end

  def render("benefit_limits.json", %{limit: limit}) do
    %{
      "limit_type": limit.limit_type,
      "limit_value": limit.limit_value
    }
  end
end
