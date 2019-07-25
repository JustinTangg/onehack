defmodule OneHackWeb.PageController do
  use OneHackWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
