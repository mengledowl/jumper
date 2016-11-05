defmodule Jumper.RegistrationControllerTest do
	use Jumper.ConnCase, asyc: true

	alias Jumper.User

	@valid_attrs %{email: "test@test.com", password: "password"}

	describe "new/2" do
		test "displays new user form", %{conn: conn} do
			response = get(conn, registration_path(conn, :new))
			assert html_response(response, 200) =~ "Create an account"
		end
	end

	describe "create/2" do
		test "creates new user if attributes are valid", %{conn: conn} do
			conn = post(conn, registration_path(conn, :create), user: @valid_attrs)
			assert redirected_to(conn) == page_path(conn, :index)
			assert Repo.get_by(User, email: @valid_attrs[:email])
		end
	end
end