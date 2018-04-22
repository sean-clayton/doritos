# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :doritos, DoritosWeb.Endpoint,
  url: [host: "localhost"],
  watchers: [yarn: ["start", cd: Path.expand("../ui", __DIR__)]],
  secret_key_base: "bAPVsMUaEyexbxEDJ5TJlYM4Zq5pYFB95fSE6uo05nJ+NqBP6A2BQYhpyQoXy3lX",
  render_errors: [view: DoritosWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Doritos.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
