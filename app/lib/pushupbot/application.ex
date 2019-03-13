defmodule Pushupbot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    slack_token = Application.get_env(:pushupbot, :slack_token)
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Pushupbot.Worker.start_link(arg)
      # {Pushupbot.Worker, arg},
      %{
        id: Slack.Bot,
        start: {Slack.Bot, :start_link, [Pushupbot.Slack, [], slack_token] }
      },
      { Pushupbot.Slack.Outgoing, [] },
      { Pushupbot.Scheduler, [] },
      { Pushupbot.Repo, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pushupbot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
