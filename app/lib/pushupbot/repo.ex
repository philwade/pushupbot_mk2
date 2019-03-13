defmodule Pushupbot.Repo do
  use Ecto.Repo,
    otp_app: :pushupbot,
    adapter: Ecto.Adapters.Postgres
end
