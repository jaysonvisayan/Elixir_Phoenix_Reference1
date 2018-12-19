defmodule Data.Schemas.AccountPlan do
  @moduledoc false

  use Data.Schema
  use Arc.Ecto.Schema

  @foreign_key_type :string
  schema "account_plans" do
    field :plan_code, :string
    field :plan_name, :string
    field :plan_type, :string
    field :plan_limit_type, :string
    field :plan_limit_amount, :decimal
    field :no_of_members, :integer
    field :no_of_benefits, :integer

    belongs_to :accounts, Data.Schemas.Account, foreign_key: :account_code
    timestamps()
  end

  def changeset(:create, struct, params \\ %{}) do
    struct
    |> cast(params, [
      :account_code,
      :plan_code,
      :plan_name,
      :plan_type,
      :plan_limit_type,
      :plan_limit_amount,
      :no_of_members,
      :no_of_benefits
    ])
  end
end

