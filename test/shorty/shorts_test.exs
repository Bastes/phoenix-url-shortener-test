defmodule Shorty.ShortsTest do
  use Shorty.DataCase

  alias Shorty.Shorts

  describe "shorts" do
    alias Shorty.Shorts.Short

    @valid_attrs %{hash_id: "some hash_id", url: "some url"}
    @invalid_attrs %{hash_id: nil, url: nil}

    def short_fixture(attrs \\ %{}) do
      {:ok, short} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shorts.create_short()

      short
    end

    test "list_shorts/0 returns all shorts" do
      short = short_fixture()
      assert Shorts.list_shorts() == [short]
    end

    test "get_short!/1 returns the short with given hash_id" do
      short = short_fixture()
      assert Shorts.get_short!(short.hash_id) == short
    end

    test "create_short/1 with valid data creates a short" do
      assert {:ok, %Short{} = short} = Shorts.create_short(@valid_attrs)
      assert short.hash_id == "some hash_id"
      assert short.url == "some url"
    end

    test "create_short/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shorts.create_short(@invalid_attrs)
    end

    test "create_short_from_url/1 with valid data creates a short" do
      url = "http://some.url/and-then-some.html"
      short_attrs = %{"url" => url}

      assert {:ok, %Short{} = short} = Shorts.create_short_from_url(short_attrs)
      assert short.url == url
      assert String.length(short.hash_id) == 8
    end

    test "delete_short/1 deletes the short" do
      short = short_fixture()
      assert {:ok, %Short{}} = Shorts.delete_short(short)
      assert_raise Ecto.NoResultsError, fn -> Shorts.get_short!(short.hash_id) end
    end

    test "change_short/1 returns a short changeset" do
      short = short_fixture()
      assert %Ecto.Changeset{} = Shorts.change_short(short)
    end
  end
end
