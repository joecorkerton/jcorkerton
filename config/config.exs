# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :jcorkerton, ecto_repos: [Jcorkerton.Repo]

# Configures the endpoint
config :jcorkerton, JcorkertonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6WpMWPOM+s//D5nXYwwFsr0Sp6eB77H2RZcXFKswf4p1fKvILHBmmYKdP2MB6I6P",
  render_errors: [view: JcorkertonWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Jcorkerton.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
