defmodule JcorkertonWeb.HomepageController do
  use JcorkertonWeb, :controller
  require Logger

  def index(conn, _params) do
    render conn, "index.html", cmc_global_values: cmc_global_values()
  end

  defp cmc_global_values do
    Cachex.fetch!(:cmc_cache, "/", &fetch_coinmarketcap_response/1)
  end

  defp fetch_coinmarketcap_response(url) do
    Logger.info "Fetching data from coinmarketcap"
    case Gateways.Coinmarketcap.Global.get(url) do
      { :ok, response } -> { :commit, response.body }
      { _, response } ->
        Logger.error("Coinmarketcap gateway error - #{inspect response}")
        Sentry.capture_exception(
          Gateways.Coinmarketcap.Error, [stacktrace: System.stacktrace(), extra: %{ response: response }]
        )
        { :ignore, nil }
    end
  end
end
