defmodule OneHackWeb.QuestionsController do
  use OneHackWeb, :controller

  alias OneHack.{Answers, Question, Questions, Users}
  alias OneHackWeb.CurrentUser

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      questions: Questions.list_questions()
    )
  end

  def new(conn, _params) do
    render(
      conn,
      "new.html",
      changeset: Questions.question_changeset(%Question{}),
      user: CurrentUser.current_user(conn)
    )
  end

  def create(conn, %{"question" => attrs}) do
    case Questions.create_question(attrs) do
      {:ok, question} ->
        to =
          question
          |> get_question_phone_number

        body =
          %{
            "api_key" => "810f8b2f",
            "api_secret" => "ruTb0YweYqkqXSEh",
            "from" => "14063155992",
            "text" => "Your question has been created with ID #{question.id}",
            "to" => to
          }
          |> Poison.encode!()

        HTTPoison.post(
          "https://rest.nexmo.com/sms/json",
          body,
          [{"Content-type", "application/json"}]
        )

        conn
        |> redirect(to: Routes.questions_path(conn, :show, question.id))
    end
  end

  @spec show(any, map) :: nil
  def show(conn, %{"id" => id}) do
    question_id =
      id
      |> convert_id

    answers =
      question_id
      |> Answers.list_answers_for_question()
      |> append_index

    question =
      question_id
      |> Questions.get_question()

    question_phone_number =
      question
      |> get_question_phone_number

    question_name =
      question.user_id
      |> Users.get_user()
      |> Map.get(:name)
      |> IO.inspect()

    render(
      conn,
      "show.html",
      question: question,
      answers: answers,
      user: CurrentUser.current_user(conn),
      question_phone_number: question_phone_number,
      question_name: question_name
    )
  end

  def convert_id(id) when is_binary(id), do: String.to_integer(id)
  def convert_id(id), do: id

  def append_index(answers) do
    answers
    |> Enum.with_index()
    |> Enum.map(fn {answer, index} ->
      answer
      |> Map.put(:index, index)
    end)
  end

  def get_question_phone_number(question) do
    question.user_id
    |> Users.get_user()
    |> Map.get(:phone_number)
  end
end
