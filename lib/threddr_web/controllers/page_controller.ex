defmodule ThreddrWeb.PageController do
  use ThreddrWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
