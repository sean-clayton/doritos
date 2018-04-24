use Mix.Config

config :doritos, DoritosWeb.Endpoint, load_from_system_env: true

# Do not print debug messages in production
config :logger, level: :info

import_config "prod.secret.exs"
