defmodule Hadrian.MixProject do
  use Mix.Project

  @version "0.0.0-automated"
  @elixir "~> 1.5"

  def project do
    [
      app: :hadrian,
      version: @version,
      elixir: @elixir,
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Hadrian.Application, []},
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
      {:epgsql, "~> 4.5"},
      # TODO: See if you can remove timex
      {:timex, "~> 3.0"},
      {:telemetry, "~> 0.4 or ~> 1.0"},
      {:retry, "~> 0.16.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:test, :dev], runtime: false},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
