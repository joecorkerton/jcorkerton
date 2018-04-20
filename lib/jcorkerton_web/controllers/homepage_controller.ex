defmodule JcorkertonWeb.HomepageController do
  use JcorkertonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", crypto_global_values: Jcorkerton.Cryptocurrency.global_values())
  end
end
