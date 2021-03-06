defmodule Doritos.Mixfile do
  use Mix.Project

  def project do
    [
      app: :doritos,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Doritos.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.2"},
      {:phoenix_pubsub, "~> 1.0"},
      {:cowboy, "~> 1.0"},
      {:absinthe_phoenix, "~> 1.4"},
      {:jason, "~> 1.0"},
      {:plug_static_index_html, "~> 1.0"},
      {:httpotion, "~> 3.1.0", override: true},
      {:flow, "~> 0.13"},
      {:httpoison, "~> 1.1"}
    ]
  end
end
