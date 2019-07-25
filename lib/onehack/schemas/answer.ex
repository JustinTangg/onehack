defmodule OneHack.Answer do
  use Ecto.Schema
  alias OneHack.{Question, User}

  schema "answers" do
    field(:answer, :string)
    field(:correct, :boolean)

    belongs_to(:question, Question)
    belongs_to(:user, User)

    timestamps()
  end
end
