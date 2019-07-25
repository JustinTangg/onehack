defmodule OneHackWeb.QuestionsView do
  use OneHackWeb, :view
  alias OneHack.Users
  alias OneHackWeb.Endpoint

  def questions_column_data do
    [
      {"question", "Question"},
      {"author", "Author"},
      {"bounty", "Bounty"},
      {"status", "Status"},
      {"inserted_at", "Created On"}
    ]
  end

  def build_questions_json(questions) do
    %{
      data: questions |> Enum.map(&question_json(&1))
    }
  end

  def question_json(question) do
    show_path = build_questions_path(question.id)

    %{
      question: "<a href=\"" <> show_path <> "\">" <> question.question <> "</a>",
      bounty: question.bounty,
      author: get_user_name(question.user_id),
      status: get_status(question.closed),
      inserted_at: question.inserted_at
    }
  end

  def get_status(true), do: "Answered"
  def get_status(false), do: "Open"

  def build_questions_path(id) do
    Routes.questions_path(Endpoint, :show, id)
  end

  def get_user_name(user_id) do
    user_id
    |> Users.get_user()
    |> Map.get(:name)
  end

  def get_user_phone_number(user_id) do
    user_id
    |> Users.get_user()
    |> Map.get(:phone_number)
  end

  def build_answers_json(answers) do
    %{
      data: answers |> Enum.map(&answer_json(&1))
    }
  end

  def answer_json(answer) do
    %{
      answer: answer.answer,
      author: get_user_name(answer.user_id),
      inserted_at: answer.inserted_at,
      phone_number: get_user_phone_number(answer.user_id)
    }
  end
end
