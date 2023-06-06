defmodule Tako.Accounts do
  use Ash.Api

  resources do
    registry Tako.Accounts.Registry
  end
end
