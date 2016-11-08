defmodule Jumper.Router do
  use Jumper.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Jumper.AssignUser
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
  end

  # Other scopes may use custom stacks.
  # scope "/api", Jumper do
  #   pipe_through :api
  # end
end
