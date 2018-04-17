defmodule JcorkertonWeb.CryptocurrencyChannel do
  use Phoenix.Channel
  require Logger

  def join("cryptocurrency:summary", _message, socket) do
    {:ok, socket}
  end

  def join("cryptocurrency:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  intercept(["new_data"])

  def handle_out("new_data", _, socket) do
    Logger.info(inspect(new_cryptocurrency_data()))
    push(socket, "new_data", new_cryptocurrency_data())
    {:noreply, socket}
  end

  defp new_cryptocurrency_data do
    import JcorkertonWeb.HomepageView

    data = Jcorkerton.Cryptocurrency.global_values()

    %{
      total_marketcap: total_marketcap(data),
      total_24_hour_volume: total_24_hour_volume(data),
      bitcoin_dominance: bitcoin_dominance(data),
      active_tokens: active_tokens(data)
    }
  end
end
