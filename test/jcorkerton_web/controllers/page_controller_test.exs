defmodule JcorkertonWeb.PageControllerTest do
  use JcorkertonWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Interesting things coming soon"
  end
end
