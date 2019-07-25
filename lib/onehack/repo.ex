defmodule OneHack.Repo do
  use Ecto.Repo,
    otp_app: :onehack,
    adapter: Ecto.Adapters.Postgres
end
