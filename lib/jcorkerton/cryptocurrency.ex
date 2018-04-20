defmodule Jcorkerton.Cryptocurrency do
  require Logger

  def global_values do
    Cachex.fetch!(:coinmarketcap, "/", &fetch_coinmarketcap_response/1)
  end

  defp fetch_coinmarketcap_response(url) do
    Logger.info("Fetching data from coinmarketcap")

    case coinmarketcap_global().get(url) do
      {:ok, response} ->
        JcorkertonWeb.Endpoint.broadcast("cryptocurrency:summary", "new_data", %{
          body: response.body
        })

        {:commit, response.body}

      {_, response} ->
        Logger.error("Coinmarketcap gateway error - #{inspect(response)}")

        Sentry.capture_exception(
          Gateways.Coinmarketcap.Error,
          stacktrace: System.stacktrace(),
          extra: %{response: response}
        )

        {:ignore, nil}
    end
  end

  defp coinmarketcap_global do
    Application.get_env(:jcorkerton, :cmc_global)
  end
end
