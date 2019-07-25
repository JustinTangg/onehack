defmodule OneHack.Question do
  use Ecto.Schema
  alias OneHack.User

  schema "questions" do
    field(:question, :string)
    field(:description, :string)
    field(:bounty, :integer)
    field(:closed, :boolean)

    belongs_to(:user, User)

    timestamps()
  end
end
