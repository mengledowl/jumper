defmodule Jumper.User do
  use Jumper.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :username, :string

    timestamps()
  end

  @required_fields ~w(email password)
  @optional_fields ~w(username)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_length(:username, min: 2)
  end

  def display_name(struct) do
    if Map.has_key?(struct, :username) && struct.username do
      struct.username
    else
      struct.email
    end
  end
end
