defmodule ShortyWeb.ShortControllerTest do
  use ShortyWeb.ConnCase

  alias Shorty.Shorts

  @create_attrs %{hash_id: "some hash_id", url: "some url"}
  @update_attrs %{hash_id: "some updated hash_id", url: "some updated url"}
  @invalid_attrs %{hash_id: nil, url: nil}

  def fixture(:short) do
    {:ok, short} = Shorts.create_short(@create_attrs)
    short
  end

  describe "index" do
    test "lists all shorts", %{conn: conn} do
      conn = get(conn, Routes.short_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Shorts"
    end
  end

  describe "new short" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.short_path(conn, :new))
      assert html_response(conn, 200) =~ "New Short"
    end
  end

  describe "create short" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.short_path(conn, :create), short: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.short_path(conn, :show, id)

      conn = get(conn, Routes.short_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Short"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.short_path(conn, :create), short: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Short"
    end
  end

  describe "edit short" do
    setup [:create_short]

    test "renders form for editing chosen short", %{conn: conn, short: short} do
      conn = get(conn, Routes.short_path(conn, :edit, short))
      assert html_response(conn, 200) =~ "Edit Short"
    end
  end

  describe "update short" do
    setup [:create_short]

    test "redirects when data is valid", %{conn: conn, short: short} do
      conn = put(conn, Routes.short_path(conn, :update, short), short: @update_attrs)
      assert redirected_to(conn) == Routes.short_path(conn, :show, short)

      conn = get(conn, Routes.short_path(conn, :show, short))
      assert html_response(conn, 200) =~ "some updated hash_id"
    end

    test "renders errors when data is invalid", %{conn: conn, short: short} do
      conn = put(conn, Routes.short_path(conn, :update, short), short: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Short"
    end
  end

  describe "delete short" do
    setup [:create_short]

    test "deletes chosen short", %{conn: conn, short: short} do
      conn = delete(conn, Routes.short_path(conn, :delete, short))
      assert redirected_to(conn) == Routes.short_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.short_path(conn, :show, short))
      end
    end
  end

  defp create_short(_) do
    short = fixture(:short)
    %{short: short}
  end
end
