defmodule Data.Schemas.Benefit do
  @moduledoc false
  use Data.Schema

  alias __MODULE__
  alias Data.{
    Contexts.UtilityContext
  }

  @primary_key {:code, :string, []}
  schema "benefits" do
    field :name, :string
    field :type, :string
    field :category, :string
    field :is_loa_facilitated, :boolean
    field :is_reimbursement, :boolean
    field :classification, :string
    field :all_diagnosis, :boolean
    field :all_procedure, :boolean
    field :frequency, :string
    field :acu_type, :string
    field :acu_type_coverage, :string
    field :is_hospital, :boolean
    field :is_clinic, :boolean
    field :is_mobile, :boolean
    field :risk_share, :string
    field :risk_share_amount, :decimal
    field :member_pays_handling, :string
    field :inserted_by, :string
    field :updated_by, :string
    field :version, :string
    field :packages, {:array, :string}

    has_many :benefit_limits, Data.Schemas.BenefitLimit, on_delete: :nothing
    has_many :benefit_packages, Data.Schemas.BenefitPackage, on_delete: :nothing

    timestamps()
  end

  def changeset_create(%Benefit{} = struct, params \\ %{}) do
    struct
    |> cast(
      params,
      [
        :code,
        :name,
        :type,
        :category,
        :is_loa_facilitated,
        :is_reimbursement,
        :classification,
        :all_diagnosis,
        :all_procedure,
        :frequency,
        :acu_type,
        :acu_type_coverage,
        :is_hospital,
        :is_clinic,
        :is_mobile,
        :risk_share,
        :risk_share_amount,
        :member_pays_handling,
        :inserted_by,
        :updated_by,
        :version
      ]
    )
    |> validate_required(
      [
        :code,
        :name
      ]
    )
  end

  def changeset_update(struct, params \\ %{}) do
    struct
    |> cast(
      params,
      [
        :name,
        :type,
        :category,
        :is_loa_facilitated,
        :is_reimbursement,
        :classification,
        :all_diagnosis,
        :all_procedure,
        :frequency,
        :acu_type,
        :acu_type_coverage,
        :is_hospital,
        :is_clinic,
        :is_mobile,
        :risk_share,
        :risk_share_amount,
        :member_pays_handling,
        :inserted_by,
        :updated_by,
        :version
      ]
    )
    |> validate_required(
      [
        :name
      ]
    )
  end

  def changeset_acu(struct, params \\ %{}) do
    struct
    |> validate_required([:code, :name, :category], message: "is required")
    |> validate_format(
        :code,
        ~r/^[ a-zA-Z0-9-_.]*$/,
        message: "only accepts special characters hyphen (-), underscore (_) and dot (.)")
    |> UtilityContext.to_upcase_value([
        :category,
        :acu_type,
        :acu_type_coverage,
        :risk_share,
        :member_pays_handling
      ])
    |> validate_length(:code, max: 60, message: "should be at most 60 character(s)")
    |> validate_length(:name, max: 400, message: "should be at most 400 character(s)")
    |> validate_inclusion(:category, ["P", "MA"], message: "is invalid")
  end

  def changeset_availment(struct, params \\ %{}) do
    struct
    |> validate_required([
        :acu_type,
        :acu_type_coverage,
        :risk_share,
        :risk_share_amount,
        :member_pays_handling,
        :is_loa_facilitated,
        :is_reimbursement,
        :is_hospital,
        :is_mobile,
        :is_clinic,
        :limit,
        :packages
      ], message: "is required")
    |> validate_inclusion(:is_loa_facilitated, [true, false], message: "is invalid")
    |> validate_inclusion(:is_reimbursement, [true, false], message: "is invalid")
    |> validate_inclusion(:is_clinic, [true, false], message: "is invalid")
    |> validate_inclusion(:is_hospital, [true, false], message: "is invalid")
    |> validate_inclusion(:is_mobile, [true, false], message: "is invalid")
    |> validate_inclusion(:all_diagnosis, [true, false], message: "is invalid")
    |> validate_inclusion(:all_procedure, [true, false], message: "is invalid")
    |> validate_inclusion(:acu_type, ["E", "R"], message: "is invalid")
    |> validate_inclusion(:acu_type_coverage, ["IP", "OP"], message: "is invalid")
    |> validate_inclusion(:risk_share, ["N", "CP", "CI"], message: "is invalid")
    |> validate_inclusion(:member_pays_handling, ["AO", "CG", "EG", "FS", "MP"], message: "is invalid")
  end
end
