defmodule TakoWeb.LeaderboardJSON do
  alias Tako.Accounts.User

  @doc """
  Renders a leaderboard.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  defp data(%User{} = user) do
    %{
      nickname: user.nickname,
      stamps_collected: user.stamps_collected
    }
  end
end
