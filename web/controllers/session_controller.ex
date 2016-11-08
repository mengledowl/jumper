defmodule Jumper.SessionController do
	use Jumper.Web, :controller

	def new(conn, _params) do
		render conn, "new.html"
	end

	def create(conn, %{"session" => session_params}) do
		case Jumper.Session.login(session_params, Jumper.Repo) do
			{:ok, user} ->
				conn
				|> put_session(:user_id, user.id)
				|> put_flash(:info, "Successfully logged in")
				|> redirect(to: "/")
			:error ->
				conn
				|> put_flash(:error, "Wrong email or password")
				|> render("new.html")
		end
	end

	def delete(conn, _) do
		conn
		|> delete_session(:user_id)
		|> put_flash(:info, "Logged out")
		|> redirect(to: "/")
	end
end