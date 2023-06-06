defmodule Tako.Accounts do
  use Ash.Api, extensions: [AshJsonApi.Api]

  resources do
    registry Tako.Accounts.Registry
  end
end
