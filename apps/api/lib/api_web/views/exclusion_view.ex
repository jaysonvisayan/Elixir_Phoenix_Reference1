defmodule ApiWeb.ExclusionView do
  use ApiWeb, :view

  def render("error.json", %{error: error}) do
    %{
      errors: error
    }
  end

  def render("search_exclusions.json", %{result: exclusions}) do
    %{
      exclusions: exclusions
    }
  end

  def render("exclusion.json", %{result: exclusion}) do
    %{
      code: exclusion.code,
      name: exclusion.name,
      type: exclusion.type,
      policies: exclusion.policies,
      classification_type: exclusion.classification,
      diagnosis_total_count: Enum.count(exclusion.diagnoses),
      diagnoses: exclusion.diagnoses,
      procedures_total_count: Enum.count(exclusion.procedures),
      procedures: exclusion.procedures
    }
  end

  # def render("view_exclusion.json", %{result: exclusion}) do
  #   %{
  #     code: exclusion
  #   }
  # end

  def render("view_exclusion.json", %{result: exclusion}) do
    %{
      code: exclusion.code,
      name: exclusion.name,
      type: exclusion.type,
      policies: exclusion.policies,
      classification_type: exclusion.classification,
      diagnosis_total_count: Enum.count(exclusion.diagnoses),
      diagnoses: exclusion.diagnoses,
      procedures_total_count: Enum.count(exclusion.procedures),
      procedures: exclusion.procedures
    }
  end
end

