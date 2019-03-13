defmodule Pushupbot.Repo.Migrations.AddSubscriptionIndex do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create index("subscriptions", [:channel_id, :team_id], unique: true, name: :channel_team_unique_id)
  end
end
