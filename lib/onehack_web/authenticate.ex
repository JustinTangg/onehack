defmodule OneHack.Authenticate do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  alias OneHack.Users

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must authenticate to access that page")
      |> redirect(to: "/")
      |> halt()
    end
  end

  def current_user(conn) do
    retrieve_user(conn.assigns.current_user)
  end

  @spec retrieve_user(nil | %{name: any}) :: any
  def retrieve_user(nil), do: nil

  def retrieve_user(current_user) do
    %{name: username} = current_user
    Users.get_user(username)
  end
end
