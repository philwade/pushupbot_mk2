defmodule Pushupbot.Slack.Outgoing do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link(_default) do
    GenServer.start_link(__MODULE__, [], name: Slackout)
  end

  # Server
  def handle_cast({:message, %{text: text, channel: channel}}, state) do
    IO.puts "got cast message text: #{text}"
    IO.puts "got cast message channel: #{channel}"
    Slack.Web.Chat.post_message(channel, text, %{ as_user: true })
    {:noreply, state}
  end

  def handle_call({:message, value}, _from, state) do
    IO.puts "got call message: #{value}"
    {:reply, "yo", state}
  end
end
