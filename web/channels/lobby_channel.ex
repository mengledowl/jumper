defmodule Jumper.LobbyChannel do
	use Phoenix.Channel

  def join("lobby:" <> room_id, _payload, socket) do
  	{:ok, assign(socket, :room_id, room_id)}
  end

  def handle_in("new_message", payload, socket) do
  	current_user = socket.assigns.user && Jumper.Repo.get(Jumper.User, socket.assigns.user)
  	broadcast! socket, "new_message", %{name: Jumper.User.display_name(current_user), message: payload["message"]}
  	{:noreply, socket}
  end
end