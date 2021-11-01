defmodule RaspboardEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RaspboardExWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RaspboardEx.PubSub},
      # Start the Endpoint (http/https)
      RaspboardExWeb.Endpoint,
      # Start a worker by calling: RaspboardEx.Worker.start_link(arg)
      {Raspboard.LightsService, name: Raspboard.LightsService}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RaspboardEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RaspboardExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
