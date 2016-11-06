defmodule Jumper.SessionControllerTest do
	use Jumper.ConnCase, async: true

	alias Jumper.User
	alias Jumper.Registration

	@credentials %{email: "test@test.com", password: "password"}

	setup do
		changeset = User.changeset(%User{}, @credentials)
		Registration.create(changeset, Jumper.Repo)
		:ok
	end

	test "new/2 should render new session page", %{conn: conn} do
		conn = get conn, session_path(conn, :new)
		assert html_response(conn, 200) =~ "Login"
	end

	test "create/2 with valid login credentials should login and redirect", %{conn: conn} do
		conn = post conn, session_path(conn, :create), session: @credentials
		assert redirected_to(conn) == page_path(conn, :index)
	end
end