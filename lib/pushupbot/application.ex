defmodule Pushupbot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Pushupbot.Worker.start_link(arg)
      # {Pushupbot.Worker, arg},
      #{ Slack.Bot, [Pushupbot.Slack, [], "c4b12a546a966e8f73fcc0d52d3df3d9"] }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pushupbot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
