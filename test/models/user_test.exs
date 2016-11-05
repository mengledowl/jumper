defmodule Jumper.UserTest do
  use Jumper.ModelCase

  alias Jumper.User

  @valid_attrs %{email: "some@email.com", password: "password"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "email must have an @" do
    attrs = %{@valid_attrs | email: "invalid"}
    assert {:email, "has invalid format"} in errors_on(%User{}, attrs)
  end

  test "password must be at least 5 characters" do
    attrs = %{@valid_attrs | password: "1234"}
    assert {:password, "should be at least 5 character(s)"} in errors_on(%User{}, attrs)
  end
end
