defmodule Data.Schemas.AccountBank do
  @moduledoc false

  use Data.Schema

  @foreign_key_type :string
  schema "account_banks" do
    field :payment_mode, :string
    field :payee_name, :string
    field :bank_account, :string
    field :bank_name, :string
    field :bank_branch, :string
    field :authority_to_debit, :boolean
    field :authorization_form, :string

    belongs_to :accounts, Data.Schemas.Account, foreign_key: :account_code

    timestamps()
  end

  def changeset(:create, struct, params \\ %{}) do
    struct
    |> cast(params, [
      :account_code,
      :payment_mode,
      :payee_name,
      :bank_account,
      :bank_name,
      :bank_branch,
      :authority_to_debit,
      :authorization_form
    ])
  end

end
