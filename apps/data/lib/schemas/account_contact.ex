defmodule Data.Schemas.AccountContact do
  @moduledoc false

  use Data.Schema
  use Arc.Ecto.Schema

  @foreign_key_type :string
  schema "account_contacts" do
    field :type, :string
    field :name, :string
    field :department, :string
    field :designation, :string
    field :telephone, {:array, :map}
    field :mobile, {:array, :map}
    field :fax, {:array, :map}
    field :email_address, :string
    field :ctc, :string
    field :ctc_date_issued, :date
    field :ctc_place_issued, :string
    field :passport, :string
    field :passport_date_issued, :date
    field :passport_place_issued, :string

    belongs_to :accounts, Data.Schemas.Account, foreign_key: :account_code

    timestamps()
  end

  def changeset(:create, struct, params \\ %{}) do
    struct
    |> cast(params, [
      :account_code,
      :type,
      :name,
      :department,
      :designation,
      :telephone,
      :mobile,
      :fax,
      :email_address,
      :ctc,
      :ctc_date_issued,
      :ctc_place_issued,
      :passport,
      :passport_date_issued,
      :passport_place_issued
    ])
  end

end
