defmodule Jcorkerton.Timer do
  use GenServer
  require Logger

  @moduledoc """
  Genserver which refreshes cryptocurrency data every 10 seconds
  """

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(_state) do
    Logger.info("Timer server started")
    schedule_timer(10_000)
    {:ok, DateTime.utc_now()}
  end

  def handle_info(:update, _) do
    refresh_data()
    schedule_timer(10_000)
    {:noreply, DateTime.utc_now()}
  end

  defp schedule_timer(interval) do
    Process.send_after(self(), :update, interval)
  end

  defp refresh_data() do
    Jcorkerton.Cryptocurrency.global_values()
  end
end
