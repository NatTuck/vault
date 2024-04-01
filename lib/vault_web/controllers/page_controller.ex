defmodule VaultWeb.PageController do
  use VaultWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home)
  end

  def pin(conn, %{"pin" => pin}) do
    if pin == "7821" do
      conn
      |> put_flash(:info, "Correct PIN")
      |> redirect(to: ~p"/")
    else
      conn
      |> put_flash(:error, "Bad PIN")
      |> redirect(to: ~p"/pin")
    end
  end

  def pin(conn, params) do
    render(conn, :pin)
  end
end
