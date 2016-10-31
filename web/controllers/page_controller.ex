defmodule Jumper.PageController do
  use Jumper.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
