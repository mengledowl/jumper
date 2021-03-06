defmodule Jumper.RegistrationController do
	use Jumper.Web, :controller
	alias Jumper.User

	def new(conn, _params) do
		changeset = User.changeset(%User{})
		render conn, changeset: changeset
	end

	def create(conn, %{"user" => user_params}) do
		changeset = User.changeset(%User{}, user_params)

		case Jumper.Registration.create(changeset, Jumper.Repo) do
			{:ok, changeset} ->
				conn
				|> put_session(:current_user, changeset.id)
				|> put_flash(:info, "Your account was successfully created!")
				|> redirect(to: "/")
			{:error, changeset} ->
				conn
				|> put_flash(:info, "Unable to create account")
				|> render("new.html", changeset: changeset)
		end
	end
end