require IEx

defmodule SessionTest do
	use Jumper.ModelCase
	use Plug.Test

	alias Jumper.Session
	alias Jumper.User
	alias Jumper.Registration

	@credentials %{"email" => "test@test.com", "password" => "password"}
	@params %{"email" => "test@test.com", "password" => "password", "username" => "username"}

	setup do
		changeset = User.changeset(%User{}, @params)
		Registration.create(changeset, Jumper.Repo)
		:ok
	end

	test "login/2 with correct credentials should create a session" do
		assert {:ok, _user} = Session.login(@credentials, Jumper.Repo)
	end

	test "login/2 with incorrect password should return error" do
		assert :error = Session.login(%{@credentials | "password" => "incorrect"}, Jumper.Repo)
	end

	test "login/2 with incorrect email should return error" do
		assert :error = Session.login(%{@credentials | "email" => "incorrect@email.com"}, Jumper.Repo)
	end
end