defmodule OneHack.Answers do
  import Ecto.{Query, Changeset}
  alias OneHack.{Answer, Repo}

  def list_answers_for_question(question_id) when is_integer(question_id) do
    Repo.all(
      from(
        a in Answer,
        join: q in assoc(a, :question),
        join: u in assoc(a, :user),
        preload: [question: q],
        preload: [user: u],
        where: a.question_id == ^question_id,
        order_by: [desc: :inserted_at]
      )
    )
  end

  def get_best_answer_for_question(question_id) when is_integer(question_id) do
    Repo.one(
      from(
        a in Answer,
        join: q in assoc(a, :question),
        join: u in assoc(a, :user),
        preload: [question: q],
        preload: [user: u],
        where: a.question_id == ^question_id and a.correct == true
      )
    )
  end

  def get_answer(id) do
    Repo.one(
      from(
        a in Answer,
        join: q in assoc(a, :question),
        join: u in assoc(a, :user),
        preload: [question: q],
        preload: [user: u],
        where: a.id == ^id
      )
    )
  end

  def post_answer(attrs) do
    %Answer{}
    |> answer_changeset(attrs)
    |> Repo.insert()
  end

  def mark_correct(attrs) do
    answer =
      attrs["id"]
      |> get_answer

    answer
    |> answer_changeset(attrs)
    |> IO.inspect()
    |> Repo.update()
  end

  @spec answer_changeset(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def answer_changeset(%Answer{} = answer, params \\ %{}) do
    answer
    |> cast(params, [
      :answer,
      :user_id,
      :question_id,
      :correct
    ])
  end
end
