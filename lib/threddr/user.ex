defmodule Threddr.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :uid, :integer
    field :name, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:uid, :name, :username])
    |> validate_required([:uid, :name, :username])
  end
end
