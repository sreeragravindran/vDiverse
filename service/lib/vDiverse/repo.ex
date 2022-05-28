defmodule VDiverse.Repo do
  use Ecto.Repo,
    otp_app: :vDiverse,
    adapter: Ecto.Adapters.Postgres
end
