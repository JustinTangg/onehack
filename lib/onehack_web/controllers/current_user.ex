defmodule OneHackWeb.CurrentUser do
  @moduledoc """
    A simple helper to get the current user from the session.
  """
  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end
end
