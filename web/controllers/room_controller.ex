defmodule Jumper.RoomController do
  require Logger
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
	  query = from m in Message, where: m.room_id == ^id, order_by: [desc: m.inserted_at]

	  room_task = Task.async(fn -> Repo.get(Room, id) end)
	  messages_task = Task.async(fn -> Repo.preload(Repo.all(query), :user) end)
	  rooms_task = Task.async(fn -> Repo.all(Room) end)

	  room = Task.await(room_task)
	  messages = Enum.reverse Task.await(messages_task)
	  rooms = Task.await(rooms_task)

		render conn, "show.html", room: room, rooms: rooms, messages: messages
	end
end