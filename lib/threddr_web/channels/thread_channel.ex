defmodule ThreddrWeb.ThreadChannel do
  use Phoenix.Channel

  def join("thread:" <> token, _params, socket) do
    case Phoenix.Token.verify(socket, System.get_env("APP_SECRET"), token, max_age: 86400) do
      {:ok, user} ->
        socket = assign(socket, :user, user)
        {:ok, socket}
      {:error, _} ->
        :error
    end
  end

  def handle_in("thread:submit", params, socket) do
    case Phoenix.Token.verify(socket, System.get_env("APP_SECRET"), params["token"], max_age: 86400) do
      {:ok, user} ->
        post_tweets(socket, user, params["tweets"])

        {:noreply, socket}
      _ ->
        :error
    end
  end

  defp post_tweets(socket, user, tweets) do
    ExTwitter.configure(:process, [
      consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
      consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
      access_token: user.access_token,
      access_token_secret: user.access_token_secret
    ])

    Enum.reduce(tweets, nil, fn(%{"index" => index, "tweet" => tweet}, previous_tweet_id) ->
      resp = ExTwitter.update(tweet, in_reply_to_status_id: previous_tweet_id)

      link = "https://twitter.com/_deadwards/status/#{resp.id}"
      broadcast!(socket, "tweet_posted", %{index: index, link: link})

      resp.id
    end)

    true
  end
end
