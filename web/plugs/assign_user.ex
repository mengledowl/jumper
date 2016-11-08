defmodule Jumper.AssignUser do
	import Plug.Conn

	def init(_opts) do
		nil
	end

	def call(conn, _opts) do
		id = get_session(conn, :user_id)
		current_user = id && Jumper.Repo.get(Jumper.User, id)
		assign(conn, :current_user, current_user)
	end
end