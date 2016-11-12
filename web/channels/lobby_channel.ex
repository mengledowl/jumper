defmodule Jumper.LobbyChannel do
	use Phoenix.Channel

  def join("lobby", _payload, socket) do
  	{:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
  	current_user = socket.assigns.user && Jumper.Repo.get(Jumper.User, socket.assigns.user)
  	broadcast! socket, "new_message", %{name: Jumper.User.display_name(current_user), message: payload["message"]}
  	{:noreply, socket}
  end
end