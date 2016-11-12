defmodule Jumper.PageControllerTest do
  use Jumper.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Jumper!"
  end
end
