defmodule DataIngestion.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DataIngestion.Repo,
      # Start the Telemetry supervisor
      DataIngestionWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DataIngestion.PubSub},

      # Fake things for this project
      DataIngestion.DemoPipeline,
      DataIngestion.AnotherDemo,
      DataIngestion.FakeProducer,

      # Start the Endpoint (http/https)
      DataIngestionWeb.Endpoint
      # Start a worker by calling: DataIngestion.Worker.start_link(arg)
      # {DataIngestion.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DataIngestion.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DataIngestionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
