use Mix.Config

config :pushupbot, Pushupbot.Scheduler,
  timezone: "America/New_York",
  jobs: [
    emit_prompts: [
      #schedule: {:cron, "* 9,10,11,12,13,14,15,16 * * 1,2,3,4,5"},
      schedule: {:cron, "0 9,10,11,12,13,14,15,16 * * 1,2,3,4,5"},
      task: {Pushupbot.Pushups, :emit_prompt, []},
    ]
  ]
