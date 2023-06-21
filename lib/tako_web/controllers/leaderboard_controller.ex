defmodule TakoWeb.LeaderboardController do
  use TakoWeb, :controller

  action_fallback TakoWeb.FallbackController

  def index(conn, _params) do
    with {:ok, users} <- Tako.Accounts.User.read_all() do
      render(conn, :index, users: users)
    end
  end
end
