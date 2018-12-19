defmodule Data.Schemas.AccountAddress do
  @moduledoc false

  use Data.Schema

  @foreign_key_type :string
  schema "account_addresses" do
    field :type, :string
    field :address_line_1, :string
    field :address_line_2, :string
    field :city, :string
    field :province, :string
    field :region, :string
    field :country, :string
    field :postal, :string

    belongs_to :accounts, Data.Schemas.Account, foreign_key: :account_code

    timestamps()
  end

  def changeset(:create, struct, params \\ %{}) do
    struct
    |> cast(params, [
      :account_code,
      :type,
      :address_line_1,
      :address_line_2,
      :city,
      :province,
      :region,
      :country,
      :postal
    ])
  end

end
