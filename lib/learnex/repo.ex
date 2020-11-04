defmodule Learnex.Repo do
  use Ecto.Repo,
    otp_app: :learnex,
    adapter: Ecto.Adapters.Postgres
end
