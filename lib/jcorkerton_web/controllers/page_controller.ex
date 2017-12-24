defmodule JcorkertonWeb.PageController do
  use JcorkertonWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
