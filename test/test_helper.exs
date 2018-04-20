Application.ensure_all_started(:hound)

Mox.defmock(Gateways.Coinmarketcap.GlobalMock, for: Gateways.Coinmarketcap.Global)
Application.put_env(:jcorkerton, :cmc_global, Gateways.Coinmarketcap.GlobalMock)

ExUnit.start()
