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

  test "Fetches the response from cmc gateway and broadcasts event", %{socket: _socket} do
    Gateways.Coinmarketcap.GlobalMock
    |> expect(:get, fn "/" -> {:ok, %{body: [foo: "bar"]}} end)

    assert Cryptocurrency.global_values() == [foo: "bar"]
    assert_broadcast("new_data", %{body: [foo: "bar"]})
    # Ensure we don't hit the Coinmarketcap endpoint again
    assert Cryptocurrency.global_values() == [foo: "bar"]
  end
end
