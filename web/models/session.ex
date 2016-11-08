defmodule Jumper.Session do
	alias Jumper.User

	def login(params, repo) do
		user = repo.get_by(User, email: String.downcase(params["email"]))

		case authenticate(user, params["password"]) do
			true	-> {:ok, user}
			_			-> :error
		end
	end

	def authenticate(user, password) do
		case user do
			nil	-> false
			_		-> Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
		end
	end

	def current_user(conn) do
		conn.assigns[:current_user]
	end

	def logged_in?(conn), do: !!current_user(conn)
end