defmodule CryptocurrencyTest do
  use ExUnit.Case, async: false
  use JcorkertonWeb.ChannelCase

  alias Jcorkerton.Cryptocurrency
  alias JcorkertonWeb.CryptocurrencyChannel

  import Mox

  setup do
    Cachex.clear(:coinmarketcap)

    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(CryptocurrencyChannel, "cryptocurrency:summary")

    {:ok, socket: socket}
  end

  setup [:set_mox_global, :verify_on_exit!]

  test "foo", %{socket: _socket} do
    response = [
      total_market_cap_usd: 1,
      total_24h_volume_usd: 3_000,
      bitcoin_percentage_of_market_cap: 0,
      active_currencies: 3_743,
      active_assets: 10
    ]

    Gateways.Coinmarketcap.GlobalMock
    |> expect(:get, fn "/" -> {:ok, %{body: response}} end)

    assert Cryptocurrency.global_values() == response
    assert_broadcast("new_data", %{body: response})
    # Ensure we don't hit the Coinmarketcap endpoint again
    assert Cryptocurrency.global_values() == response
  end
end
