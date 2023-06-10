defmodule TakoWeb.UserSocket do
  use Phoenix.Socket

  # A Socket handler
  #
  # It's possible to control the websocket connection and
  # assign values that can be accessed by your channel topics.

  ## Channels
  channel "notifications:*", TakoWeb.NotificationsChannel
  #
  # To create a channel file, use the mix task:
  #
  #     mix phx.gen.channel Room
  #
  # See the [`Channels guide`](https://hexdocs.pm/phoenix/channels.html)
  # for further details.

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error` or `{:error, term}`. To control the
  # response the client receives in that case, [define an error handler in the
  # websocket
  # configuration](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#socket/3-websocket-configuration).
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(%{"userToken" => user_token}, socket, _connect_info) do
    case Tako.Accounts.User.get_by_id(user_token) do
      {:ok, _user} -> {:ok, assign(socket, :user_token, user_token)}
      {:error, _reason} -> {:error, :unauthorized}
    end
  end

  def connect(_params, _socket, _connect_info) do
    {:error, :unauthorized}
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Elixir.TakoWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  @impl true
  def id(socket), do: "user_socket:#{socket.assigns.user_token}"
end
