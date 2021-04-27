defmodule DataIngestion.Repo do
  use Ecto.Repo,
    otp_app: :data_ingestion,
    adapter: Ecto.Adapters.Postgres
end
