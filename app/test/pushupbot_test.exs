defmodule PushupbotTest do
  use ExUnit.Case
  doctest Pushupbot

  test "greets the world" do
    assert Pushupbot.hello() == :world
  end
end
