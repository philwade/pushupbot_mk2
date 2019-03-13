defmodule Pushupbot.Subscription do
  use Ecto.Schema

  schema "subscriptions" do
    field :team_id, :string
    field :channel_id, :string
  end

  def changeset(subscription, params \\ %{}) do
    subscription
    |> Ecto.Changeset.cast(params,  [:team_id, :channel_id])
    |> Ecto.Changeset.validate_required([:team_id, :channel_id])
    |> Ecto.Changeset.unique_constraint(:channel_id, name: :channel_team_unique_id)
  end
end
