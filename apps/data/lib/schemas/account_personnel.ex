defmodule Data.Schemas.AccountPersonnel do
  @moduledoc false

  use Data.Schema

  @foreign_key_type :string
  schema "account_personnels" do
    field :personnel, :string
    field :specialization, :string
    field :location, :string
    field :schedule, :string
    field :no_of_personnel, :integer
    field :payment_mode, :string
    field :retainer_fee, :string
    field :amount, :decimal

    belongs_to :accounts, Data.Schemas.Account, foreign_key: :account_code

    timestamps()
  end

  def changeset(:create, struct, params \\ %{}) do
    struct
    |> cast(params, [
      :account_code,
      :personnel,
      :specialization,
      :location,
      :schedule,
      :no_of_personnel,
      :payment_mode,
      :retainer_fee,
      :amount
    ])
  end

end
