defmodule Jumper.RoomView do
	use Jumper.Web, :view

	def get_active_class(room, target_room) do
		if room.id == target_room.id do
			"active"
		end
	end
end