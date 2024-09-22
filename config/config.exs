# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :teapot_backend,
  ecto_repos: [TeapotBackend.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :teapot_backend, TeapotBackendWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: TeapotBackendWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TeapotBackend.PubSub,
  live_view: [signing_salt: "sAIkSUd8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Commanded
config :teapot_backend, TeapotBackend.Cmd,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: TeapotBackend.EventStore
  ],
  pubsub: :local,
  registry: :local

config :teapot_backend, event_stores: [
  TeapotBackend.EventStore
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
