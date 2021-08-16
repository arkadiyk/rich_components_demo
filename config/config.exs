# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rich_components_demo,
  ecto_repos: [RichComponentsDemo.Repo]

# Configures the endpoint
config :rich_components_demo, RichComponentsDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "L+na6u9dMax4byBfQlg9SPVVCjcXnin1ZPMXo+qRQCeHtRJXBey4WXurNEcphOpj",
  render_errors: [view: RichComponentsDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RichComponentsDemo.PubSub,
  live_view: [signing_salt: "PzvIbc8h"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
