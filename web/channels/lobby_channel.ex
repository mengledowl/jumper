defmodule Jumper.LobbyChannel do
	use Phoenix.Channel

	alias Jumper.Message
	alias Jumper.Repo

  def join("lobby:" <> room_id, _payload, socket) do
  	{:ok, assign(socket, :room_id, room_id)}
  end

  def handle_in("new_message", payload, socket) do
  	current_user = socket.assigns.user && Jumper.Repo.get(Jumper.User, socket.assigns.user)

  	changeset = Message.changeset(%Message{}, %{user_id: current_user.id, room_id: socket.assigns.room_id, value: payload["message"]})

  	{:ok, message} = Repo.insert(changeset)

  	broadcast! socket, "new_message", %{name: Jumper.User.display_name(current_user), message: message.value}
  	{:noreply, socket}
  end
end