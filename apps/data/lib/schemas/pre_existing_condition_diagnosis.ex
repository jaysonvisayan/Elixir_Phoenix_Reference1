defmodule Data.Schemas.PreExistingConditionDiagnosis do
  @moduledoc false

  use Data.Schema

  alias Data.Schemas.{
    PreExistingCondition,
    Diagnosis
  }

  @foreign_key_type :string
  schema "pre_existing_condition_diagnoses" do
    belongs_to :pre_existing_condition, PreExistingCondition, foreign_key: :pre_existing_condition_code
    belongs_to :diagnosis, Diagnosis, foreign_key: :diagnosis_code

    timestamps()
  end

  def changeset(:create, struct, params) do
    struct
    |> cast(params, [
      :diagnosis_code,
      :pre_existing_condition_code
    ])
  end

end
