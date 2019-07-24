defmodule ThreddrWeb.ThreadsController do
  use ThreddrWeb, :controller

  plug :require_current_user

  def new(conn, _params) do
    user = get_session(conn, :current_user)
    token = Phoenix.Token.sign(conn, System.get_env("APP_SECRET"), user)

    render(conn, "new.html", token: token)
  end

  defp require_current_user(conn, _params) do
    case get_session(conn, :current_user) do
      nil ->
        conn
        |> put_flash(:error, "You need to sign in before continuing.")
        |> redirect(to: "/")
        |> halt()
      current_user ->
        conn
        |> assign(:current_user, current_user)
    end
  end
end
