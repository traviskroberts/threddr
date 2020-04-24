defmodule Threddr.MixProject do
  use Mix.Project

  def project do
    [
      app: :threddr,
      version: "0.1.1",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Threddr.Application, []},
      extra_applications: [:extwitter, :logger, :runtime_tools, :ueberauth_twitter]
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
      {:distillery, "~> 2.1"},
      {:extwitter, "~> 0.9"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:oauth, github: "tim/erlang-oauth"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix, "~> 1.4.9"},
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.0", override: true},
      {:ueberauth_twitter, "~> 0.2"}
    ]
  end

  defp aliases do
    []
  end
end
