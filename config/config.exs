import Config

config :tako,
  ecto_repos: [Tako.Repo]

# For backwards compatibility, the following configuration is required.
# see https://ash-hq.org/docs/guides/ash/latest/get-started#temporary-config for more details
config :ash, :use_all_identities_in_manage_relationship?, false

config :tako,
  ash_apis: [Tako.Accounts]

config :tako, TakoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: TakoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Tako.PubSub,
  live_view: [signing_salt: "4mqzdN2i"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
