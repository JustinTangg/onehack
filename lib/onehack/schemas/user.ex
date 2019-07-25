defmodule OneHack.User do
  use Ecto.Schema

  schema "users" do
    field(:username, :string)
    field(:email, :string)
    field(:name, :string)
    field(:phone_number, :string)
    field(:password, :string)

    timestamps()
  end
end
