defmodule OneHackWeb.UsersController do
  use OneHackWeb, :controller

  alias OneHack.{User, Users}

  def create(conn, %{"user" => attrs}) do
    case Users.create_user(attrs) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, Users.get_user(user.id))
        |> redirect(to: Routes.questions_path(conn, :index))
    end
  end

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    render(
      conn,
      "new.html",
      changeset: Users.user_changeset()
    )
  end
end
