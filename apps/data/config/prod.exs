use Mix.Config

config :data, Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DB_USER") || "${DB_USER}",
  password: System.get_env("DB_PASSWORD") || "${DB_PASSWORD}",
  hostname: System.get_env("DB_HOST") || "${DB_HOST}",
  database: System.get_env("DB_NAME") || "${DB_NAME}",
  pool_size: 5,
  types: Data.PostgrexTypes
