defmodule Chika.MixProject do
  use Mix.Project

  def project do
    [
      app: :chika,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Chika, []}
    ]
  end

  defp deps do
    [
      {:poison, "~> 4.0"},
      {:httpoison, "~> 1.8"},
      {:alchemy, "~> 0.7.0", hex: :discord_alchemy}
    ]
  end
end
