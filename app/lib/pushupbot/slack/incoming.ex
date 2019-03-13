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
    IO.puts "Got team #{slack.team.id}"
    if Regex.run ~r/^<@#{slack.me.id}>/, message.text do

      if Regex.run ~r/^<@#{slack.me.id}> do pushups here/, message.text do
        subscription = %Pushupbot.Subscription{ channel_id: message.channel, team_id: slack.team.id}
        changeset = Pushupbot.Subscription.changeset(subscription)

        case Pushupbot.Repo.insert(changeset) do
          {:ok, _} ->
            send_message("<@#{message.user}> now pushing up in this channel", message.channel, slack)
          {:error, _} ->
            send_message("<@#{message.user}> something screwed up badly with your pushup setup", message.channel, slack)
        end
      else
        response = Pushupbot.Personality.respond(message.text)
        send_message("<@#{message.user}> #{response}", message.channel, slack)
      end
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
