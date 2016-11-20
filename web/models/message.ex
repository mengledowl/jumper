defmodule Jumper.Message do
  use Jumper.Web, :model

  schema "messages" do
    field :value, :string
    belongs_to :room, Jumper.Room
    belongs_to :user, Jumper.User

    timestamps()
  end

  @required_fields ~w(value user_id room_id)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
  end
end
