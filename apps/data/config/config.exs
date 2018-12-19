use Mix.Config

config :data, ecto_repos: [Data.Repo]

config :data, env: Mix.env

config :data, arc_storage: :local

import_config "#{Mix.env()}.exs"
