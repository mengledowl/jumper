defmodule Jumper.UserTest do
  use Jumper.ModelCase, async: true

  alias Jumper.User

  @valid_attrs %{email: "some@email.com", password: "password", username: "someone"}
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

  test "username must be at least 2 characters" do
    attrs = %{@valid_attrs | username: "a"}
    assert {:username, "should be at least 2 character(s)"} in errors_on(%User{}, attrs)
  end

  test "display_name/1 should return username if present" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert User.display_name(changeset.changes) == @valid_attrs.username
  end

  test "display_name/1 should return email if username not present" do
    changeset = User.changeset(%User{}, %{email: "some@email.com", password: "password"})
    assert User.display_name(changeset.changes) == @valid_attrs.email
  end

  test "display_name/1 should return email if username present but empty" do
    changeset = User.changeset(%User{}, %{@valid_attrs | username: ""})
    assert User.display_name(changeset.changes) == @valid_attrs.email
  end
end
