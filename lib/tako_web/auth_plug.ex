defmodule TakoWeb.AuthPlug do
  @moduledoc """
  API authentication plug. Verifies that the request has a valid token.
  """
  import Plug.Conn
  import Phoenix.Controller, only: [text: 2]
  require Logger

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         :ok <- Tako.verify_token(token) do
      conn
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> text("Unauthorized")
        |> halt()
    end
  end
end
