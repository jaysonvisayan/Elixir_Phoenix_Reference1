defmodule Data.Schemas.AccountApprover do
  @moduledoc false

  use Data.Schema
  use Arc.Ecto.Schema

  @foreign_key_type :string
  schema "account_approvers" do
    field :username, :string
    field :name, :string
    field :telephone, :string
    field :mobile, :string
    field :email, :string

    belongs_to :accounts, Data.Schemas.Account, foreign_key: :account_code
    timestamps()
  end

  def changeset(:create, struct, params \\ %{}) do
    struct
    |> cast(params, [
      :account_code,
      :username,
      :name,
      :telephone,
      :mobile,
      :email
    ])
  end
end

