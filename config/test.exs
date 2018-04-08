use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jcorkerton, JcorkertonWeb.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :jcorkerton, Jcorkerton.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "jcorkerton_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :exvcr, [
  vcr_cassette_library_dir: "test/vcr_cassettes",
  custom_cassette_library_dir: "test/custom_cassettes",
  filter_sensitive_data: [
    [pattern: "<PASSWORD>.+</PASSWORD>", placeholder: "PASSWORD_PLACEHOLDER"]
  ],
  filter_url_params: false,
  filter_request_headers: [],
  response_headers_blacklist: [],
  ignore_localhost: true
]

config :hound, driver: "chrome_driver", browser: "chrome_headless"
