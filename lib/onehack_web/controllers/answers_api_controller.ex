defmodule OneHackWeb.AnswersApiController do
  use OneHackWeb, :controller

  alias OneHack.{Answers}

  def post(conn, %{"attrs" => attrs}) do
    case Answers.post_answer(attrs) do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> json("Answer added successfully")
    end
  end

  def correct(conn, %{"attrs" => attrs}) do
    case Answers.mark_correct(attrs) do
      {:ok, _} ->
        conn
        |> put_status(:ok)
        |> json("Marked successfully")
    end
  end
end
