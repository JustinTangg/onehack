defmodule OneHackWeb.LoginApiController do
  use OneHackWeb, :controller

  alias OneHack.Users

  def validate(conn, %{"credentials" => credentials}) do
    user = Users.get_user_by_username(credentials["username"])

    if not is_valid_username?(user) do
      conn
      |> put_status(404)
      |> json("Not Found")
    else
      if credentials["password"] == user.password do
        conn
        |> put_session(:current_user, user)
        |> redirect(to: Routes.questions_path(conn, :index))
      else
        conn
        |> put_status(401)
        |> json("Unauthorized")
      end
    end
  end

  def is_valid_username?(nil), do: false
  def is_valid_username?(_user), do: true
end
