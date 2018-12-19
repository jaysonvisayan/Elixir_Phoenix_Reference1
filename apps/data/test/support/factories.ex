defmodule Data.Factory do
  @moduledoc "All mock data used for testing are defined here"
  use ExMachina.Ecto, repo: Data.Repo

  alias Data.Schemas.{
    Benefit,
    BenefitLimit,
    Clinic,
    Package,
    Account,
    AccountAddress,
    AccountContact,
    AccountBank,
    AccountPersonnel,
    AddressLookUp,
    GenericLookUp,
    Exclusion,
    Diagnosis,
    PreExistingCondition,
    Package,
    AccountAddress,
    AccountContact,
    AccountBank,
    AccountPersonnel,
    BenefitPackage,
    Procedure,
    Plan,
    PlanPreExistingCondition,
    Exclusion,
    AccountPlan,
    AccountApprover
  }

  def clinic_factory do
    %Clinic{}
  end

  def benefit_factory do
    %Benefit{}
  end

  def benefit_limit_factory do
    %BenefitLimit{}
  end

  def package_factory do
    %Package{}
  end

  def diagnosis_factory do
    %Diagnosis{}
  end

  def pre_existing_conditions_factory do
    %PreExistingCondition{}
  end

  def account_factory do
    %Account{}
  end

  def account_address_factory do
    %AccountAddress{}
  end

  def account_contact_factory do
    %AccountContact{}
  end

  def account_bank_factory do
    %AccountBank{}
  end

  def account_personnel_factory do
    %AccountPersonnel{}
  end

  def address_look_up_factory do
    %AddressLookUp{}
  end

  def generic_look_up_factory do
    %GenericLookUp{}
  end

  def exclusion_factory do
    %Exclusion{}
  end

  def benefit_package_factory do
    %BenefitPackage{}
  end

  def procedure_factory do
    %Procedure{}
  end

  def plan_factory do
    %Plan{}
  end

  def plan_pre_existing_conditions_factory do
    %PlanPreExistingCondition{}
  end

  def exclusions_factory do
    %Exclusion{}
  end

  def account_address_factory do
    %AccountAddress{}
  end

  def account_contact_factory do
    %AccountContact{}
  end

  def account_bank_factory do
    %AccountBank{}
  end

  def account_personnel_factory do
    %AccountPersonnel{}
  end

  def account_plan_factory do
    %AccountPlan{}
  end

  def account_approver_factory do
    %AccountApprover{}
  end
end
