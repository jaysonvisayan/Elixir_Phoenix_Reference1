use Mix.Config

config :data, Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "apd_dev",
  pool_size: 2,
  types: Data.PostgrexTypes

# config :data, Data.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   hostname: "172.16.45.77",
#   database: "apd_ist",
#   pool_size: 2,
#   types: Data.PostgrexTypes
