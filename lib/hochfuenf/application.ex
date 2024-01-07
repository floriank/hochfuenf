defmodule Hochfuenf.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HochfuenfWeb.Telemetry,
      Hochfuenf.Repo,
      {DNSCluster, query: Application.get_env(:hochfuenf, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hochfuenf.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hochfuenf.Finch},
      # Start a worker by calling: Hochfuenf.Worker.start_link(arg)
      # {Hochfuenf.Worker, arg},
      # Start to serve requests, typically the last entry
      HochfuenfWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hochfuenf.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HochfuenfWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
