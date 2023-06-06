defmodule Tako.Accounts.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Tako.Accounts.User
  end
end
