defmodule Jumper.RegistrationTest do
	use Jumper.ModelCase

	alias Jumper.User
	alias Jumper.Registration

	@valid_attrs %{email: "some@email.com", password: "password", username: "username"}

	test "create/2 should create a User with encrypted password" do
		changeset = Jumper.User.changeset(%User{}, @valid_attrs)

		{:ok, registration} = Registration.create(changeset, Jumper.Repo)

		assert Repo.get(User, registration.id)
		assert registration.encrypted_password != nil
		assert registration.encrypted_password != "password"
	end
end