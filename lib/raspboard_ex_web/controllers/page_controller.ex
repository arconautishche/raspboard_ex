defmodule RaspboardExWeb.PageController do
  use RaspboardExWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
