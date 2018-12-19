defmodule Data.Schemas.BenefitLimit do
  @moduledoc false
  use Data.Schema

  alias __MODULE__

  @foreign_key_type :string
  schema "benefit_limits" do
    field :limit_type, :string
    field :limit_value, :string
    # field :limit_amount, :decimal
    # field :limit_session, :string
    # field :limit_percentage, :integer
    field :is_quadrant, :boolean
    field :is_site, :boolean
    field :limit_area_site, :string
    field :limit_classification, :string
    field :coverage_codes, {:array, :string}

    belongs_to :benefit, Data.Schemas.Benefit, foreign_key: :benefit_code
  end

  def changeset(%BenefitLimit{} = struct, params \\ %{}) do
    struct
    |> cast(params, [
        :limit_type,
        :limit_value,
        # :limit_session,
        # :limit_percentage,
        :is_quadrant,
        :is_site,
        :limit_area_site,
        :limit_classification,
        :coverage_codes,
        :benefit_code
      ])
  end

end
