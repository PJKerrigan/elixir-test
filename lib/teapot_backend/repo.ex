defmodule TeapotBackend.Repo do
  use Ecto.Repo,
    otp_app: :teapot_backend,
    adapter: Ecto.Adapters.Postgres
end
