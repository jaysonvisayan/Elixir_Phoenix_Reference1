defmodule ApiWeb.V1.PreExistingConditionView do
  use ApiWeb, :view

  def render("pec.json", %{result: result}) do
    %{
      code: result.code,
      name: result.name,
      diagnosis: result.diagnoses,
      conditions: result.conditions
    }
  end

  def render("pec_diagnosis.json", %{pec_diagnosis: pec_diagnosis}) do
    %{
      code: pec_diagnosis.diagnosis.code,
      description: pec_diagnosis.diagnosis.desc
    }
  end

  def render("pec_conditions.json", %{pec_condition: pec_condition}) do
    %{
      is_same_coverage_period_as_account: pec_condition.is_same_coverage_period_as_account,
      member_type: pec_condition.member_type,
      disease_category: pec_condition.disease_category,
      duration: pec_condition.duration,
      inner_limit_type: pec_condition.inner_limit_type,
      inner_limit_value: pec_condition.inner_limit_value
    }
  end

  def render("error.json", %{error: error}) do
    %{
      errors: error
    }
  end

  def render("pre-existing_condition.json", %{result: result}) do
    %{
      code: result.code
    }
  end

  def render("pre-existing_conditions.json", %{result: pre_existing_conditions}) do
    %{
      total_number: Enum.count(pre_existing_conditions),
      pre_existing_conditions: pre_existing_conditions
    }
  end

end
