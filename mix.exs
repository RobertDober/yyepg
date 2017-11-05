defmodule Yyepg.Mixfile do
  use Mix.Project

  def project do
    [
      app: :yyepg,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      package: package(),
      deps: deps(),
      dialyzer: [plt_add_deps: :project, ignore_warnings: "dialyzer.ignore-warnings"]
    ]
  end

  defp package do
    [
      files: [
        "lib", "src", "mix.exs", "README.md"
      ],
      maintainers: [
        "Robert Dober <robert.dober@gmail.com>",
      ],
      licenses: [
        "Apache 2 (see the file LICENSE for details)"
      ],
      links: %{
        "GitHub" => "https://github.com/RobertDober/yyepg",
      }
    ]
  end
  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 0.5.1", only: [:dev], runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
