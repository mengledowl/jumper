defmodule Jumper.RoomController do
	use Jumper.Web, :controller
	alias Jumper.Room
	alias Jumper.Message

	plug :put_layout, "chat.html"

	def index(conn, _params) do
	  count = Room.count

	  if count > 0 do
	    query = from r in Room,
	            select: r.id,
	            limit: 1
	    id = Repo.one(query)
	    redirect(conn, to: room_path(conn, :show, id))
    else
      redirect(conn, to: room_path(conn, :new))
	  end
	end

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
		query = from m in Message, where: m.room_id == ^room.id, order_by: [desc: m.inserted_at], limit: 50
		messages = Enum.reverse Repo.all(query)
		messages = Repo.preload(messages, :user)

		rooms = Repo.all(Room)
		render conn, "show.html", room: room, rooms: rooms, messages: messages
	end
end