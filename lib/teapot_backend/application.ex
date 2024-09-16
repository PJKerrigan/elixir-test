defmodule TeapotBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Commanded.
      TeapotBackend.Repo,
      TeapotBackend.Cmd,
      TeapotBackend.Customers.Supervisors.Customer,
      TeapotBackend.Customers.Supervisors.CustomerId,

      # Phoenix.
      TeapotBackendWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:teapot_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TeapotBackend.PubSub},
      # Start a worker by calling: TeapotBackend.Worker.start_link(arg)
      # {TeapotBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      TeapotBackendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TeapotBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TeapotBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
