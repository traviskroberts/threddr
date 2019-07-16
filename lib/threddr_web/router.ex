defmodule ThreddrWeb.Router do
  use ThreddrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ThreddrWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/auth", ThreddrWeb do
    pipe_through :browser

    delete "/log-out", AuthController, :logout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
end
