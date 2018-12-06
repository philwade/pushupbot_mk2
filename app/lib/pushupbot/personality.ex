defmodule Pushupbot.Personality do
  @positive [
    "hey that's great!",
    "just like bruce willis!",
    "we're all part of the same energy",
    "you know what's a great show? The office",
    "I got nothing but love for you",
    "Imagine a world without war or politicians",
    "that rules",
    "the spirit of christmas is in most of us",
    "I like you too! Let's take a trip down south that'll make us both rich",
    "you seem like a nice person",
    "let's hug it out, pal",
    "in addition to pushups, yoga can have many positive effects on your life",
  ]

  @negative [
    "hey pal, push it up yours",
    "that's a terrible thing to say",
    "if you don't watch it the only plank you'll be doing is in a coffin",
    "I'm going to go bazooka joe on your ass",
    "despite the name, I don't take getting pushed around lying down",
    "here's a thought: pokemon-go jump off a dang bridge",
    "here's an idea: I'm going to take you to castlevapia and then smoke you. Like a vape stick",
  ]

  @neutral [
    "neutral",
    "tell my wife I said 'hello'",
    "You said something to me",
    "damn right I work",
    "the color gray is considered neutral but so it dark green I believe",
    "hmm, hard to say",
    "oh wow, damn",
  ]

  defp get_neutral_response() do
    Enum.random(@neutral)
  end

  defp get_negative_response() do
    Enum.random(@negative)
  end

  defp get_positive_response() do
    Enum.random(@positive)
  end

  def respond(incoming_message) do
    sentiment = Veritaserum.analyze(incoming_message)

    cond do
      sentiment < 0 -> get_negative_response()
      sentiment > 1 -> get_positive_response()
      true -> get_neutral_response()
    end
  end
end
