use Mix.Config

config :api, ApiWeb.Endpoint,
  load_from_system_env: true,
  http: [:inet6, port: "${PORT}"],
  url: [host: "${URL}", port: "${PORT}"],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: "${SECRET_KEY_BASE}",
  server: true,
  root: ".",
  version: Application.spec(:api, :vsn)

config :logger, level: :info

config :sentry,
  dsn: "${SENTRY_DSN}",
  environment_name: String.to_atom("${SENTRY_ENV}"),
  enable_source_code_context: true,
  root_source_code_path: File.cwd!,
  tags: %{
    env: "${SENTRY_ENV}",
    app_version: "#{Application.spec(:api, :vsn)}"
  },
  included_environments: [:ist, :migration, :staging, :uat, :prod_staging, :prod]
