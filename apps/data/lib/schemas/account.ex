defmodule Data.Schemas.Account do
  @moduledoc false

  use Data.Schema

  @primary_key {:code, :string, []}
  schema "accounts" do
    field :status, :string
    field :step, :string
    field :photo, :string
    field :segment, :string
    field :name, :string
    field :type, :string
    field :industry, :string
    field :effective_date, :date
    field :expiry_date, :date
    field :address_same_as_billing, :boolean
    field :tin, :string
    field :vat_status, :string
    field :previous_carrier, :string
    field :attachment_point, :string
    field :bank_same_as_funding, :boolean
    field :inserted_by, :string
    field :updated_by, :string
    field :version, :string

    has_many :account_addresses, Data.Schemas.AccountAddress, on_delete: :delete_all, foreign_key: :account_code
    has_many :account_contacts, Data.Schemas.AccountContact, on_delete: :delete_all, foreign_key: :account_code
    has_many :account_banks, Data.Schemas.AccountBank, on_delete: :delete_all, foreign_key: :account_code
    has_many :account_personnels, Data.Schemas.AccountPersonnel, on_delete: :delete_all, foreign_key: :account_code
    has_many :account_plans, Data.Schemas.AccountPlan, on_delete: :delete_all, foreign_key: :account_code
    has_many :account_approvers, Data.Schemas.AccountApprover, on_delete: :delete_all, foreign_key: :account_code

    timestamps()
  end

  def changeset(:create, struct, params \\ %{}) do
    struct
    |> cast(params, [
        :code,
        :status,
        :step,
        :photo,
        :segment,
        :name,
        :type,
        :industry,
        :effective_date,
        :expiry_date,
        :address_same_as_billing,
        :tin,
        :vat_status,
        :previous_carrier,
        :attachment_point,
        :bank_same_as_funding,
        :inserted_by,
        :updated_by,
        :version
    ])
  end

end
