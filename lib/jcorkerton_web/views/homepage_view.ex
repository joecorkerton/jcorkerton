defmodule JcorkertonWeb.HomepageView do
  use JcorkertonWeb, :view
  require Number

  def total_marketcap(cmc_global_values) do
    total_marketcap = cmc_global_values[:total_market_cap_usd]
    "$#{Number.Human.number_to_human(total_marketcap)}"
  end

  def total_24_hour_volume(cmc_global_values) do
    total_24_hour_volume = cmc_global_values[:total_24h_volume_usd]
    "$#{Number.Human.number_to_human(total_24_hour_volume)}"
  end

  def bitcoin_dominance(cmc_global_values) do
    bitcoin_dominance = cmc_global_values[:bitcoin_percentage_of_market_cap]
    Number.Percentage.number_to_percentage(bitcoin_dominance, precision: 2)
  end

  def active_tokens(cmc_global_values) do
    active_tokens = cmc_global_values[:active_currencies] + cmc_global_values[:active_assets]
    Number.Delimit.number_to_delimited(active_tokens, precision: 0)
  end
end
