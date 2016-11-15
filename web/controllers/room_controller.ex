defmodule Jumper.RoomController do
	use Jumper.Web, :controller
	alias Jumper.Room

	def new(conn, _params) do
		changeset = Room.changeset(%Room{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"room" => room_params}) do
		changeset = Room.changeset(%Room{}, room_params)

		case Repo.insert(changeset) do
			{:ok, room} ->
				redirect(conn, to: room_path(conn, :show, room))
			{:error, changeset} ->
				conn
				|> render("new.html", changeset: changeset)
		end
	end

	def show(conn, %{"id" => id}) do
		room = Repo.get(Room, id)
		rooms = Repo.all(Room)
		render conn, "show.html", room: room, rooms: rooms
	end
end