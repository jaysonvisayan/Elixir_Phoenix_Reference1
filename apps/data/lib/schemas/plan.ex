defmodule Data.Schemas.Plan do
  use Data.Schema
  @moduledoc false

  alias Ecto.Changeset

  @primary_key {:code, :string, []}
  schema "plans" do
    field :category, :string
    field :name, :string
    field :description, :string
    field :type, :string
    field :classification, :string
    field :applicability, :string
    field :phic_status, :string
    field :exclusion_codes, {:array, :string}
    field :grace_principal_type, :string
    field :grace_principal_value, :integer
    field :grace_dependent_type, :string
    field :grace_dependent_value, :integer
    field :max_no_dependents, :integer
    field :default_effective_date, :string
    field :is_no_outright_denial, :boolean
    field :is_loa_facilitated, :boolean
    field :is_reimbursement, :boolean
    field :loa_validity, :integer
    field :application_of_limit, :string
    field :is_sonny_medina, :boolean
    field :is_hospital_bill, :boolean
    field :is_professional_fee, :boolean
    field :principal_schedule, :string
    field :dependent_schedule, :string
    field :updated_by, :string
    field :inserted_by, :string

    has_many :plan_age_eligibilities, Data.Schemas.PlanAgeEligibility, on_delete: :delete_all
    has_many :plan_pre_existing_conditions, Data.Schemas.PlanPreExistingCondition, on_delete: :delete_all
    has_many :plan_benefits, Data.Schemas.PlanBenefit, on_delete: :delete_all
    has_many :plan_limits, Data.Schemas.PlanLimit, on_delete: :delete_all
    has_many :plan_coverages, Data.Schemas.PlanCoverage, on_delete: :delete_all
    has_many :plan_hoed, Data.Schemas.PlanHoed, on_delete: :delete_all

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :code,
      :category,
      :name,
      :description,
      :type,
      :classification,
      :applicability,
      :phic_status,
      :exclusion_codes,
      :grace_principal_type,
      :grace_principal_value,
      :grace_dependent_type,
      :grace_dependent_value,
      :max_no_dependents,
      :default_effective_date,
      :is_no_outright_denial,
      :loa_validity,
      :application_of_limit,
      :is_sonny_medina,
      :is_hospital_bill,
      :is_professional_fee,
      :principal_schedule,
      :dependent_schedule,
      :updated_by,
      :inserted_by
    ])
  end

  def medical_changeset(struct, params \\ %{}) do
    struct
    |> validate_inclusion(:is_no_outright_denial, [true, false], message: "is invalid")
    |> validate_inclusion(:is_loa_facilitated, [true, false], message: "is invalid")
    |> validate_inclusion(:is_hospital_bill, [true, false], message: "is invalid")
    |> validate_inclusion(:is_professional_fee, [true, false], message: "is invalid")
    |> validate_inclusion(:is_reimbursement, [true, false], message: "is invalid")
    |> validate_inclusion(:is_sonny_medina, [true, false], message: "is invalid")
    |> validate_inclusion(:type, ["B", "S", "G", "P", "PP"], message: "is invalid")
    |> validate_inclusion(:phic_status, ["required to file", "optional to file"], message: "is invalid")
    |> validate_inclusion(:applicability, ["P", "D", "G"], message: "is invalid")
    |> validate_inclusion(:classification, ["S", "C"], message: "is invalid")
    |> validate_inclusion(:application_of_limit, ["LT", "LNT"], message: "is invalid")
    |> validate_inclusion(:grace_principal_type, ["days", "months"], message: "is invalid")
    |> validate_inclusion(:grace_dependent_type, ["days", "months"], message: "is invalid")
  end
end
