import_file("~/.iex.exs")

defmodule Utils do
  def list_routes, do: Tako.Accounts.User |> AshJsonApi.Resource.Info.routes()
end
