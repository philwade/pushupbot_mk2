defmodule Pushupbot.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pushupbot,
      version: "0.1.2",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :slack],
      mod: {Pushupbot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:slack, "~> 0.12.0"},
      {:quantum, ">= 2.3.0"},
      {:timex, "~> 3.0"},
      {:distillery, "~> 2.0"}
    ]
  end
end
