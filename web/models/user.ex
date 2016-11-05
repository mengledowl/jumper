defmodule Jumper.User do
  use Jumper.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @required_fields ~w(email password)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
  end
end
