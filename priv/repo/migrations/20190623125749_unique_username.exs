defmodule OneHack.Repo.Migrations.UniqueUsername do
  use Ecto.Migration

  def change do
    create(unique_index(:users, [:username, :phone_number]))
  end
end
