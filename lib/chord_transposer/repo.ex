defmodule ChordTransposer.Repo do
  use Ecto.Repo,
    otp_app: :chord_transposer,
    adapter: Ecto.Adapters.Postgres
end
