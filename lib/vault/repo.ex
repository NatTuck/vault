defmodule Vault.Repo do
  use Ecto.Repo,
    otp_app: :vault,
    adapter: Ecto.Adapters.SQLite3
end
