defmodule Pushupbot.Slack do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    IO.puts "Connected as #{slack.me.id}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    IO.puts "Got message #{message.text}"
    IO.puts "Got user #{message.user}"
    if Regex.run ~r/^<@#{slack.me.id}>/, message.text do
      send_message("<@#{message.user}> damn right I work", message.channel, slack)
    end
    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    IO.puts "Sending your message, captain!"

    send_message(text, channel, slack)

    {:ok, state}
  end
  def handle_info(_, _, state), do: {:ok, state}
end
