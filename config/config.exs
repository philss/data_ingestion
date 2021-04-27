# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :data_ingestion,
  ecto_repos: [DataIngestion.Repo]

# Configures the endpoint
config :data_ingestion, DataIngestionWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9mb0dQsBhgD//VMHA810Y/V9j6haw/b9UKKKizCZHhxDr/Q68AfnX4Vi/j7Bq/KI",
  render_errors: [view: DataIngestionWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DataIngestion.PubSub,
  live_view: [signing_salt: "y65unx7d"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
