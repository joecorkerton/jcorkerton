defmodule HomepageTest do
  use ExUnit.Case, async: false
  use Hound.Helpers
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Hound.Element

  import Mox

  hound_session()

  setup [:set_mox_global, :verify_on_exit!]

  test "displays the navbar" do
    Cachex.clear(:coinmarketcap)

    response = [
      total_market_cap_usd: 1,
      total_24h_volume_usd: 3_000,
      bitcoin_percentage_of_market_cap: 0,
      active_currencies: 3_743,
      active_assets: 10
    ]

    Gateways.Coinmarketcap.GlobalMock
    |> stub(:get, fn "/" -> {:ok, %{body: response}} end)

    navigate_to("/")
    assert(String.contains?(visible_page_text(), "Total market cap"))
    assert(String.contains?(visible_page_text(), "24 hour volume"))
    assert(String.contains?(visible_page_text(), "Bitcoin dominance"))
    assert(String.contains?(visible_page_text(), "Active tokens"))
    assert Element.element?(find_element(:class, "fa-github"))
    assert Element.element?(find_element(:class, "fa-linkedin-square"))
  end
end
