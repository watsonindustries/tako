defmodule Tako do
  @moduledoc """
  Tako keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @spec verify_token(String.t()) :: :ok | {:error, :invalid_token}
  def verify_token(token) do
    expected_token = Application.get_env(:tako, :holoquest_api_token)

    cond do
      expected_token == "" -> :ok
      token == expected_token -> :ok
      true -> {:error, :invalid_token}
    end
  end
end
