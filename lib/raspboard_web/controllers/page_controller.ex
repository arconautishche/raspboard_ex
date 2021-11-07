defmodule RaspboardWeb.PageController do
  use RaspboardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
