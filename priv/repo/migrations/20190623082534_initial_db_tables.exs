defmodule OneHack.Repo.Migrations.InitialDbTables do
  use Ecto.Migration

  def change do
    create table("users") do
      add(:username, :string, null: false)
      add(:password, :string, null: false)
      add(:email, :string)
      add(:name, :string)
      add(:phone_number, :string)

      timestamps()
    end

    create table("questions") do
      add(:question, :text, null: false)
      add(:description, :text)
      add(:bounty, :integer)
      add(:user_id, references(:users))
      add(:closed, :boolean, null: false, default: false)

      timestamps()
    end

    create table("answers") do
      add(:answer, :text, null: false)
      add(:user_id, references(:users))
      add(:question_id, references(:questions))
      add(:correct, :boolean, default: false)

      timestamps()
    end
  end
end
