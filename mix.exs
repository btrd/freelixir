defmodule Freelixir.Mixfile do
  use Mix.Project

  def project do
    [app: :freelixir,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.9.0"}]
  end

  defp description do
    """
    Send SMS to yourself with Free Mobile API.
    """
  end

  defp package do
    [
      maintainers: ["Jean Bertrand"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/btrd/freelixir"}
    ]
  end
end
