defmodule Pushupbot.Repo.Migrations.AddHumanReadable do
  use Ecto.Migration

  def change do
    alter table("subscriptions") do
      add :human_readable_name, :string
    end
  end
end
