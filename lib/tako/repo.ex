defmodule Tako.Repo do
  use AshPostgres.Repo,
    otp_app: :tako,
    adapter: Ecto.Adapters.Postgres

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
