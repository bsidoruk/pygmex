defmodule Pygmex.Mixfile do
  use Mix.Project

  def project do
    [ app: :pygmex,
      version: "0.0.1",
      elixir: "~> 0.15.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  defp deps do
    []
  end
end
