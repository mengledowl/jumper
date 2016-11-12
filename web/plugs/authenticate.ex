defmodule Jumper.Authenticate do
	import Plug.Conn
	import Phoenix.Controller

	def init(_) do
		nil
	end

	def call(conn, _opts) do
		if conn.assigns.current_user do
			conn
		else
			conn
			|> put_flash(:error, "You must be signed in to view this page")
			|> redirect(to: "/")
		end
	end
end