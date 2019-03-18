defmodule Pushupbot.Control do
  import Ecto.Query

  def parse_incoming_message(message, slack) do
    case parsemessage(slack.me.id, message) do
      {:add_subscription} ->
        add_sub(message, slack)
      {:remove_subscription} ->
        remove_sub(message, slack)
      {:talk_back} ->
        response = Pushupbot.Personality.respond(message.text)
        {:send_response, response}
      {:noop} ->
        {:noop, nil}
    end
  end

  defp do_send (subscription) do
    message = Pushupbot.Pushups.get_prompt()
    GenServer.cast(Slackout, {:message, %{text: message, channel: subscription.channel_id}})
  end

  def send_outgoing_messages() do
    Pushupbot.Subscription
    |> Pushupbot.Repo.all
    |> Enum.each(fn sub -> do_send(sub) end)
  end

  defp add_sub(message, slack) do
    subscription = %Pushupbot.Subscription{
                      channel_id: message.channel,
                      team_id: slack.team.id,
                      human_readable_name: "#{slack.team.name} : #{slack.channels[message.channel].name}"}
    changeset = Pushupbot.Subscription.changeset(subscription)

    case Pushupbot.Repo.insert(changeset) do
      {:ok, _} ->
        {:send_response, "now pushing up in this channel"}
      {:error, _} ->
        {:send_response, "something screwed up badly with your pushup setup"}
    end
  end

  defp remove_sub(message, slack) do
    subscription = Pushupbot.Subscription
                    |> Ecto.Query.where([channel_id: ^message.channel, team_id: ^slack.team.id])
                    |> Pushupbot.Repo.one
    if subscription == nil do
      {:send_response, "I'm not doing pushups in this channel already"}
    else
      case Pushupbot.Repo.delete(subscription) do
        {:ok, _}
          -> {:send_response, "not doing pushups here anymore"}
        {:error, _}
          -> {:send_response, "something terrible has happened"}
      end
    end
  end

  defp parsemessage(my_id, message) do
    if Regex.run ~r/^<@#{my_id}>/, message.text do
      cond do
        Regex.run ~r/^<@#{my_id}> do pushups here/, message.text ->
          {:add_subscription}
        Regex.run ~r/^<@#{my_id}> stop doing pushups/, message.text ->
          {:remove_subscription}
        true ->
          {:talk_back}
      end
    else
      {:noop}
    end
  end

end
