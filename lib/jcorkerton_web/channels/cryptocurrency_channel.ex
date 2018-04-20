defmodule JcorkertonWeb.CryptocurrencyChannel do
  use Phoenix.Channel
  require Logger

  @moduledoc """
  Channel to update clients with new cryptocurrency data
  """

  def join("cryptocurrency:summary", _message, socket) do
    {:ok, socket}
  end

  def join("cryptocurrency:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  intercept(["new_data"])

  def handle_out("new_data", data, socket) do
    push(socket, "new_data", format_data(data[:body]))
    {:noreply, socket}
  end

  defp format_data(data) do
    import JcorkertonWeb.HomepageView

    %{
      total_marketcap: total_marketcap(data),
      total_24_hour_volume: total_24_hour_volume(data),
      bitcoin_dominance: bitcoin_dominance(data),
      active_tokens: active_tokens(data)
    }
  end
end
