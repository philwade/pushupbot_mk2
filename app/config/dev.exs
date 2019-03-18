use Mix.Config

config :pushupbot, Pushupbot.Repo,
  database: "pushupbot_repo",
  username: "pwade",
  password: "pass",
  hostname: "localhost"

config :pushupbot, Pushupbot.Scheduler,
  timezone: "America/New_York",
  jobs: [
    emit_prompts: [
      #schedule: {:cron, "* 9,10,11,12,13,14,15,16 * * 1,2,3,4,5"},
      schedule: {:cron, "0 16 * * 1,2,3,4,5"},
      task: {Pushupbot.Control, :send_outgoing_messages, []},
    ]
  ]
