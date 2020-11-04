defmodule LearnexWeb.PageController do
  use LearnexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
