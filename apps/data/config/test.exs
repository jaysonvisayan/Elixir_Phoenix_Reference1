use Mix.Config

config :data, Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432",
  database: "apd_test",
  types: Data.PostgrexTypes,
  pool: Ecto.Adapters.SQL.Sandbox
