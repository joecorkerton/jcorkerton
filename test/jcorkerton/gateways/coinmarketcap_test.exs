defmodule Gateways.CoinmarketcapTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "global" do
    alias Gateways.Coinmarketcap.Global

    setup do
      Global.start()
    end

    test "queries the coinmarketcap global api" do
      use_cassette "coinmarketcap_global_get" do
        response = Global.get!("/")
        assert response.status_code == 200
        assert response.body[:total_market_cap_usd] |> is_float
        assert response.body[:total_24h_volume_usd] |> is_float
        assert response.body[:bitcoin_percentage_of_market_cap] |> is_float
        assert response.body[:active_currencies] |> is_integer
        assert response.body[:active_assets] |> is_integer
        assert response.body[:active_markets] |> is_integer
        assert response.body[:last_updated] |> is_integer
      end
    end
  end
end
