defmodule Pushupbot.Slack.Outgoing do
  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, [], name: Slackout)
  end

  # Server
  def handle_cast({:message, value}, state) do
    IO.puts "got message #{value}"
    Slack.Web.Chat.post_message("#shame-week", value)
    {:noreply, state}
  end

  def handle_call({:message, value}, _from, state) do
    IO.puts "got message #{value}"
    {:reply, "yo", state}
  end
end
