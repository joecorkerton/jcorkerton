defmodule JcorkertonWeb.HomepageControllerTest do
  use JcorkertonWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Total market cap:"
  end
end
