defmodule Tako.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TakoWeb.Telemetry,
      # Start the Ecto repository
      Tako.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tako.PubSub},
      # Start Finch
      {Finch, name: Tako.Finch},
      # Start the Endpoint (http/https)
      TakoWeb.Endpoint
      # Start a worker by calling: Tako.Worker.start_link(arg)
      # {Tako.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tako.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TakoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
