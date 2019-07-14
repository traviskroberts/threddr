defmodule Threddr.Auth do
  import Ecto.Changeset, warn: false
  import Ecto.Query

  alias Ueberauth.Auth
  alias Threddr.Repo
  alias Threddr.User

  def register(%Auth{} = auth) do
    case Repo.get_by(User, uid: auth.uid) do
      nil -> create_user(auth)
      user -> {:ok, user}
    end
  end

  defp create_user(auth) do
    attrs = %{
      uid: auth.uid,
      name: auth.info.name,
      username: auth.info.nickname
    }

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
