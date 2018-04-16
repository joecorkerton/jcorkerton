defmodule Gateways.Coinmarketcap do
  defmodule Error do
    defexception message: "Coinmarketcap gateway error"
  end

  defmodule Global do
    use HTTPoison.Base

    @expected_fields ~w(
      total_market_cap_usd total_24h_volume_usd bitcoin_percentage_of_market_cap active_currencies active_assets
      active_markets last_updated
    )

    def process_url(url) do
      "https://api.coinmarketcap.com/v1/global" <> url
    end

    def process_response_body(body) do
      body
      |> Poison.decode!()
      |> Map.take(@expected_fields)
      |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
    end
  end
end
