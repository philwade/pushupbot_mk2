defmodule Pushupbot.Slack do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    IO.puts "Connected as #{slack.me.id}"
    {:ok, state}
  end

  def handle_event(message = %{type: "channel_joined"}, slack, state) do
    IO.puts "Joined channel #{message.channel.name}"
    response = "Hi, I'm pushupbot. If you'd like pushup reminders here on the hour, say '@pushupbot do pushups here'. If you want me to stop, say '@pushupbot stop doing pushups'."
    send_message(response, message.channel.id, slack)
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    IO.puts "Got message #{message.text}"
    IO.puts "Got user #{message.user}"
    IO.puts "Got team #{slack.team.id}"
    case Pushupbot.Control.parse_incoming_message(message, slack) do
      {:send_response, response} ->
        send_message("<@#{message.user}> #{response}", message.channel, slack)
      {_, _} ->
        {:ok, state}
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
