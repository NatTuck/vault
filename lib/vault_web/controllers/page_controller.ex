defmodule VaultWeb.PageController do
  use VaultWeb, :controller

  plug :get_team
  plug :set_pass

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

  def step3p(conn, %{"sums" => sums}) do
    if Enum.all?(sums, &(elem(&1, 0) == elem(&1, 1))) do
      conn
      |> render(:step3, guess: "", feedback: "", correct: "")
    else 
      conn
      |> put_flash(:error, "Bad sum")
      |> redirect(to: ~p"/")
    end
  end

  def step3(conn, %{"pass" => pass}) do
    correct = conn.assigns[:pass]
    if pass == correct do
      redirect(conn, to: ~p"/step4")
    else
      pairs = Enum.drop(Enum.zip(String.split(pass, ""), String.split(correct, "")), 1)
      fb = Enum.map pairs, fn {aa, bb} ->
        if aa == bb do
          "1"
        else
          "0"
        end
      end
      render(conn, :step3, guess: pass, correct: "[redacted]", feedback: Enum.join(fb, ""))
    end
  end

  def step4(conn, _params) do
    render(conn, :step4)
  end

  def get_team(conn, _args) do
    if team = get_session(conn, :team) do
      assign(conn, :team, team)
    else
      conn
    end
  end

  def set_pass(conn, _args) do
    pass = get_session(conn, :pass) || Vault.Puzzles.random_password(8)
    conn
    |> put_session(:pass, pass)
    |> assign(:pass, pass)
  end
end
