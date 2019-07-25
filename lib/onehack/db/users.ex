defmodule OneHack.Users do
  import Ecto.{Query, Changeset}
  alias OneHack.{User, Repo}

  def get_user(id) when is_integer(id) do
    Repo.one(
      from(
        u in User,
        where: u.id == ^id
      )
    )
  end

  def get_user_by_phone_number(phone_number) do
    Repo.one(
      from(
        u in User,
        where: u.phone_number == ^phone_number
      )
    )
  end

  def create_user(attrs) do
    attrs
    |> user_changeset
    |> Repo.insert()
  end

  def get_user_by_username(username) do
    Repo.one(
      from(
        u in User,
        where: u.username == ^username
      )
    )
  end

  def user_changeset(params \\ %{}) do
    %User{}
    |> cast(params, [
      :username,
      :password,
      :email,
      :name,
      :phone_number
    ])
    |> validate_required([
      :username,
      :password,
      :name
    ])
  end
end
