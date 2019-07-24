defmodule ThreddrWeb.AuthController do
  use ThreddrWeb, :controller
  plug Ueberauth

  alias Threddr.Auth

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case auth do
      %{
        uid: uid,
        info: %{name: name, nickname: nickname},
        credentials: %{token: access_token, secret: acess_token_secret}
      } ->
        attrs = %{
          uid: uid,
          name: name,
          username: nickname,
          access_token: access_token,
          access_token_secret: acess_token_secret
        }
        conn
        |> put_session(:current_user, attrs)
        |> configure_session(renew: true)
        |> redirect(to: "/threads/new")
      _ ->
        conn
        |> put_flash(:error, "There was an error authenticating.")
        |> redirect(to: "/")
    end
  end

  def logout(conn, _params) do
    conn
    |> put_session(:current_user, nil)
    |> redirect(to: "/")
  end
end
