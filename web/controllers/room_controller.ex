defmodule Jumper.RoomController do
	use Jumper.Web, :controller

	def show(conn, _params) do
		render conn, "show.html"
	end
end