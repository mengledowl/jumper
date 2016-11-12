defmodule Jumper.Router do
  use Jumper.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Jumper.AssignUser
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Jumper do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/registraions", RegistrationController, only: [:new, :create]

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    get "/rooms", RoomController, :show
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Jumper do
  #   pipe_through :api
  # end
end
