# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  # If you are running Phoenix, you should make sure that
  # server: true is set and the code reloader is disabled,
  # even in dev mode.
  # It is recommended that you build with MIX_ENV=prod and pass
  # the --env flag to Distillery explicitly if you want to use
  # dev mode.
  set dev_mode: true
  set include_erts: false
  set cookie: :"j3H(&;4,k2o:E2`jP?|0nXF*FnqrE,pMj^wTp]%m&cz,~pNIragi;kt_t>;n<bxV"
end

environment :staging do
  set include_erts: false
  set include_src: false
  set cookie: :"wbnpK2wIoEvi1C7gM6y5I/kPFDe1HIgdMcR/yEVKL0lHmrOSxEhPCgjpeHm7r8Rd"
end

environment :uat do
  set include_erts: false
  set include_src: false
  set cookie: :"BCvPkUupzC67w93Gq7vrfJXwHnndSyXFFQWwXqljUu2GDiy1p+l1LLVYwI8lRBHJ"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"6[HIn_KQ%kQ8rK[RAoDAo7sOS}13Ac**xmUltklIp%sg67qxu_R0Y}P*C182_&FN"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :api do
  set version: current_version(:api)
  set vm_args: Path.join(Path.expand(__DIR__), "./rel/api.args.prod")
  set applications: [
    :runtime_tools,
    api: :permanent,
    data: :permanent
  ]
end
