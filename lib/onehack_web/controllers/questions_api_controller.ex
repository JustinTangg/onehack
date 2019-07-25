defmodule OneHackWeb.QuestionsApiController do
  use OneHackWeb, :controller

  alias OneHack.Questions

  def close(conn, %{"attrs" => attrs}) do
    case Questions.mark_closed(attrs) do
      {:ok, _} ->
        conn
        |> put_status(:ok)
        |> json("Marked successfully")
    end
  end
end
