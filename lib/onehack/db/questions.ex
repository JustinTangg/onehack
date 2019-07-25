defmodule OneHack.Questions do
  import Ecto.{Query, Changeset}
  alias OneHack.{Question, Repo}

  def list_questions do
    Repo.all(
      from(
        q in Question,
        join: u in assoc(q, :user),
        preload: [user: u]
      )
    )
  end

  def get_question(id) when is_binary(id) do
    id
    |> String.to_integer()
    |> get_question()
  end

  def get_question(id) when is_integer(id) do
    Repo.one(
      from(
        q in Question,
        join: u in assoc(q, :user),
        preload: [user: u],
        where: q.id == ^id
      )
    )
  end

  def create_question(attrs) do
    %Question{}
    |> question_changeset(attrs)
    |> Repo.insert()
  end

  def mark_closed(attrs) do
    question =
      attrs["id"]
      |> get_question

    question
    |> question_changeset(attrs)
    |> Repo.update()
  end

  @spec question_changeset(
          OneHack.Question.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def question_changeset(%Question{} = question, params \\ %{}) do
    question
    |> cast(params, [
      :question,
      :description,
      :bounty,
      :user_id,
      :closed
    ])
    |> validate_required([
      :question,
      :user_id
    ])
  end
end
