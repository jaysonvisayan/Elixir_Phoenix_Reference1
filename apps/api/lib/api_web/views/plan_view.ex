defmodule ApiWeb.PlanView do
  use ApiWeb, :view

  def render("error.json", %{error: error}) do
    %{
      errors: error
    }
  end

  def render("plans.json", %{result: []}) do
    %{
      error: %{"search": "No plans matched your search"}
    }
  end

  def render("plans.json", %{result: result}) do
    %{
      total_number: length(result),
      plans: result
    }
  end

  def render("all_params.json", %{result: plan}) do
    %{
      category: plan.category,
      code: plan.code,
      name: plan.name,
      description: plan.description,
      type: plan.type,
      classification: plan.classification,
      applicability: plan.applicability,
      phic_status: plan.phic_status,
      exclusion_codes: plan.exclusion_codes,
      exclusions: render_many(
        plan.exclusions, ApiWeb.PlanView,
        "plan_exclusions.json",
        as: :plan_exclusions
      ),
      plan_pre_existing_conditions: render_many(
        plan.plan_pre_existing_conditions, ApiWeb.PlanView,
        "plan_pre_existing_conditions.json",
        as: :plan_pre_existing_conditions
      ),
      benefit: render_many(
        plan.plan_benefits, ApiWeb.PlanView,
        "plan_benefits.json",
        as: :plan_benefits
      ),
      limits: render_many(
        plan.plan_limits, ApiWeb.PlanView,
        "plan_limits.json",
        as: :plan_limits
      ),
      coverages: render_many(
        plan.plan_coverages, ApiWeb.PlanView,
        "plan_coverages.json",
        as: :plan_coverages
      ),
      facilities: render_one(
        plan.facilities, ApiWeb.PlanView,
        "plan_facilities.json",
        as: :facilities
      ),
      risk_share_specific: render_many(
        plan.risk_shares, ApiWeb.PlanView,
        "plan_risk_share.json",
        as: :risk_shares
      ),
      hoed: render_many(
        plan.plan_hoed, ApiWeb.PlanView,
        "plan_hoed.json",
        as: :plan_hoed
      ),
      default_effective_date: plan.default_effective_date,
      is_no_outright_denial: plan.is_no_outright_denial,
      is_loa_facilitated: plan.is_loa_facilitated,
      is_reimbursement: plan.is_reimbursement,
      loa_validity: plan.loa_validity,
      application_of_limit: plan.application_of_limit,
      is_sonny_medina: plan.is_sonny_medina,
      is_hospital_bill: plan.is_hospital_bill,
      is_professional_fee: plan.is_professional_fee,
      principal_schedule: plan.principal_schedule,
      dependent_schedule: plan.dependent_schedule,
      inserted_by: plan.inserted_by,
      updated_by: plan.updated_by,
      updated_at: plan.updated_at
    }
  end

  def render("exclusion_tab.json", %{result: plan}) do
    %{
      category: plan.category,
      code: plan.code,
      name: plan.name,
      description: plan.description,
      type: plan.type,
      classification: plan.classification,
      applicability: plan.applicability,
      phic_status: plan.phic_status,
      exclusion_codes: plan.exclusion_codes,
      exclusions: render_many(
        plan.exclusions, ApiWeb.PlanView,
        "plan_exclusions.json",
        as: :plan_exclusions
      ),
      plan_pre_existing_conditions: render_many(
        plan.plan_pre_existing_conditions, ApiWeb.PlanView,
        "plan_pre_existing_conditions.json",
        as: :plan_pre_existing_conditions
      )
    }
  end

  def render("benefit_tab.json", %{result: plan}) do
    %{
      category: plan.category,
      code: plan.code,
      name: plan.name,
      description: plan.description,
      type: plan.type,
      classification: plan.classification,
      applicability: plan.applicability,
      phic_status: plan.phic_status,
      exclusion_codes: plan.exclusion_codes,
        benefit: render_many(
          plan.plan_benefits, ApiWeb.PlanView,
          "plan_benefits.json",
          as: :plan_benefits
        ),
        limits: render_many(
          plan.plan_limits, ApiWeb.PlanView,
          "plan_limits.json",
          as: :plan_limits
        )
    }
  end

  def render("coverage_tab.json", %{result: plan}) do
    %{
      category: plan.category,
      code: plan.code,
      name: plan.name,
      description: plan.description,
      type: plan.type,
      classification: plan.classification,
      applicability: plan.applicability,
      phic_status: plan.phic_status,
      exclusion_codes: plan.exclusion_codes,
        coverages: render_many(
          plan.plan_coverages, ApiWeb.PlanView,
          "plan_coverages.json",
          as: :plan_coverages
        ),
        facilities: render_one(
          plan.facilities, ApiWeb.PlanView,
          "plan_facilities.json",
          as: :facilities
        ),
        risk_share_specific: render_many(
          plan.risk_shares, ApiWeb.PlanView,
          "plan_risk_share.json",
          as: :risk_shares
        ),
    }
  end

  def render("condition_tab.json", %{result: plan}) do
      %{
        category: plan.category,
        code: plan.code,
        name: plan.name,
        description: plan.description,
        type: plan.type,
        classification: plan.classification,
        applicability: plan.applicability,
        phic_status: plan.phic_status,
        exclusion_codes: plan.exclusion_codes,
          hoed: render_many(
            plan.plan_hoed, ApiWeb.PlanView,
            "plan_hoed.json",
            as: :plan_hoed
          ),
        default_effective_date: plan.default_effective_date,
        is_no_outright_denial: plan.is_no_outright_denial,
        is_loa_facilitated: plan.is_loa_facilitated,
        is_reimbursement: plan.is_reimbursement,
        loa_validity: plan.loa_validity,
        application_of_limit: plan.application_of_limit,
        is_sonny_medina: plan.is_sonny_medina,
        is_hospital_bill: plan.is_hospital_bill,
        is_professional_fee: plan.is_professional_fee,
        principal_schedule: plan.principal_schedule,
        dependent_schedule: plan.dependent_schedule,
        inserted_by: plan.inserted_by,
        updated_by: plan.updated_by,
        updated_at: plan.updated_at
      }
  end

  def render("plan_exclusions.json", %{plan_exclusions: plan_exclusion}) do
    %{
      code: plan_exclusion.code,
      name: plan_exclusion.name,
      type: plan_exclusion.type
    }
  end

  def render("plan_pre_existing_conditions.json", %{plan_pre_existing_conditions: plan_pre_existing_conditions}) do
    %{
      pec_code: plan_pre_existing_conditions.pec_code,
      is_same_coverage_period_as_account: plan_pre_existing_conditions.is_same_coverage_period_as_account,
      member_type: plan_pre_existing_conditions.member_type,
      disease_category: plan_pre_existing_conditions.disease_category,
      duration: plan_pre_existing_conditions.duration,
      inner_limit_type: plan_pre_existing_conditions.inner_limit_type,
      inner_limit_value: plan_pre_existing_conditions.inner_limit_value
     }
  end

  def render("plan_coverages.json", %{plan_coverages: plan_coverages}) do
    %{
      coverage_code: plan_coverages.coverage_code,
      funding_arrangement: plan_coverages.funding_arrangement,
      member_pays_handling: plan_coverages.member_pays_handling,
      is_room_category: plan_coverages.is_room_category,
      is_amount: plan_coverages.is_amount,
      amount_type: plan_coverages.amount_type,
      is_days: plan_coverages.is_days,
      days_type: plan_coverages.days_type,
      days_value: plan_coverages.days_value,
      room_upgrade: plan_coverages.room_upgrade,
      incremental_cost: plan_coverages.incremental_cost,
      is_facility_all_coverage: plan_coverages.is_facility_all_coverage,
      facility_type: plan_coverages.facility_type,
      facility_group_codes: plan_coverages.facility_group_codes,
      excluded_facility_codes: plan_coverages.excluded_facility_codes,
      specific_facility_codes: plan_coverages.specific_facility_codes,
      is_risk_share_all_coverage: plan_coverages.is_risk_share_all_coverage,
      risk_share_all_type: plan_coverages.risk_share_all_type,
      risk_share_all_value: plan_coverages.risk_share_all_value,
      rs_member_pays_handling: plan_coverages.rs_member_pays_handling
     }
  end

  def render("plan_facilities.json", %{facilities: facilities}) do
    if Enum.empty?(facilities) do
      []
    else
    %{
      code: facilities.code,
      name: facilities.name,
      type: facilities.type
    }
    end
  end

  def render("plan_risk_share.json", %{risk_shares: risk_shares}) do
    %{
      facility_code: risk_shares.facility_code,
      risk_share_type: risk_shares.risk_share_type,
      risk_share_value: risk_shares.risk_share_value,
      rs_member_pays_handling: risk_shares.rs_member_pays_handling
     }
  end

  def render("plan_benefits.json", %{plan_benefits: plan_benefits}) do
    %{
      benefit_code: plan_benefits.benefit_code,
      coverage_code: plan_benefits.coverage_code,
      limit_type: plan_benefits.limit_type,
      limit_value: plan_benefits.limit_value,
     }
  end

  def render("plan_limits.json", %{plan_limits: plan_limits}) do
    %{
      coverage_code: plan_limits.coverage_code,
      limit_type: plan_limits.limit_type,
      limit_amount: plan_limits.limit_amount,
      extension_limit: plan_limits.extension_limit
     }
  end

  def render("plan_hoed.json", %{plan_hoed: plan_hoed}) do
    %{
      civil_status: plan_hoed.civil_status,
      dependent_hierarchy: plan_hoed.dependent_hierarchy
     }
  end
end
