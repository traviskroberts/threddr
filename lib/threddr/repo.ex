defmodule Threddr.Repo do
  use Ecto.Repo,
    otp_app: :threddr,
    adapter: Ecto.Adapters.Postgres
end
