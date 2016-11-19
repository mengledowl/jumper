defmodule Jumper.Room do
  use Jumper.Web, :model

  schema "rooms" do
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def count do
    query = from r in Jumper.Room,
    	      select: count(r.id)
    Jumper.Repo.all(query)
  end
end
