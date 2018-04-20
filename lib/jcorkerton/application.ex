defmodule Jcorkerton.Application do
  use Application

  @moduledoc false

  import Cachex.Spec

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(JcorkertonWeb.Endpoint, []),
      worker(Cachex, [
        :coinmarketcap,
        [
          expiration:
            expiration(
              default: :timer.minutes(5),
              interval: :timer.seconds(30),
              lazy: true
            )
        ]
      ]),
      worker(Jcorkerton.Timer, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jcorkerton.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    JcorkertonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
