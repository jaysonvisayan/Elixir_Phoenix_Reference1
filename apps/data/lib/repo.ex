defmodule Data.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :data,
    adapter: Ecto.Adapters.Postgres
end
