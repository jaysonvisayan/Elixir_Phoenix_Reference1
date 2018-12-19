defmodule APD.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),

      # Docs
      name: "APD Domain",
      source_url: "https://gitlab.medilink.com.ph/open-source-team/v2/apd",
      homepage_url: "https://www.medilink.com.ph",
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dogma, "~> 0.1", only: :dev},
      {:sobelow, "~> 0.7", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      "scan.all": ["scan.code", "scan.security"],
      "scan.security": ["sobelow --root apps/api -i Config.HTTPS"],
      "scan.code": ["credo"],
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.seed": ["run apps/data/priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.reset-seed": ["ecto.drop", "ecto.setup", "ecto.seed"]
    ]
  end
end
