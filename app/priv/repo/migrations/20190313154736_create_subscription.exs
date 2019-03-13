defmodule Pushupbot.Repo.Migrations.CreateSubscription do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :team_id, :string
      add :channel_id, :string
    end

  end
end
