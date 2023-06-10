defmodule TakoWeb.NotificationsChannel do
  @moduledoc """
  Channel for handling generic notifications.
  """
  use TakoWeb, :channel

  @spec ping_all :: :noconnect | :nosuspend | :ok
  def ping_all() do
    Process.send(self(), :ping, [])
  end

  @impl true
  def join("notifications:scans", _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("collected", %{"nickname" => nickname} = _payload, socket) do
    # fan out the same payload, but check that nickname is there
    broadcast!(socket, "collected-broadcast", %{nickname: nickname})
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("pong", _payload, socket) do
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (notifications:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_info(:ping, socket) do
    broadcast(socket, "ping", %{msg: "ping"})
    {:noreply, socket}
  end
end
