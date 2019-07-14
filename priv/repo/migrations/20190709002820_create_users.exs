defmodule Threddr.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uid, :integer
      add :name, :string
      add :username, :string

      timestamps()
    end

  end
end
