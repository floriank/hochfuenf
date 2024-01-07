defmodule Hochfuenf.Repo do
  use Ecto.Repo,
    otp_app: :hochfuenf,
    adapter: Ecto.Adapters.Postgres
end
