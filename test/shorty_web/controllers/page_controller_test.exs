defmodule ShortyWeb.PageControllerTest do
  use ShortyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "This is Shorty!"
  end
end
