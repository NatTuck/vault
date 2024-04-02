defmodule VaultWeb.PageController do
  use VaultWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def step2(conn, %{"team" => team}) do
    case Integer.parse(team) do
      {team_no, ""} ->
        add_pairs = Vault.Puzzles.add_pairs()

        conn
        |> put_session(:team, team_no)
        |> render(:step2, team: team_no, add_pairs: add_pairs)
      _else ->
        conn
        |> put_flash(:error, "Bad team #")
        |> redirect(to: ~p"/")
    end
  end

  def step3(conn, params) do
    IO.inspect(params)
    render(conn, :step3)
  end
end
