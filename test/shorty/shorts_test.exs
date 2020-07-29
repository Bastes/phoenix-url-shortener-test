defmodule Shorty.ShortsTest do
  use Shorty.DataCase

  alias Shorty.Shorts

  describe "shorts" do
    alias Shorty.Shorts.Short

    @valid_attrs %{hash_id: "some hash_id", url: "some url"}
    @update_attrs %{hash_id: "some updated hash_id", url: "some updated url"}
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

    test "get_short!/1 returns the short with given id" do
      short = short_fixture()
      assert Shorts.get_short!(short.id) == short
    end

    test "create_short/1 with valid data creates a short" do
      assert {:ok, %Short{} = short} = Shorts.create_short(@valid_attrs)
      assert short.hash_id == "some hash_id"
      assert short.url == "some url"
    end

    test "create_short/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shorts.create_short(@invalid_attrs)
    end

    test "update_short/2 with valid data updates the short" do
      short = short_fixture()
      assert {:ok, %Short{} = short} = Shorts.update_short(short, @update_attrs)
      assert short.hash_id == "some updated hash_id"
      assert short.url == "some updated url"
    end

    test "update_short/2 with invalid data returns error changeset" do
      short = short_fixture()
      assert {:error, %Ecto.Changeset{}} = Shorts.update_short(short, @invalid_attrs)
      assert short == Shorts.get_short!(short.id)
    end

    test "delete_short/1 deletes the short" do
      short = short_fixture()
      assert {:ok, %Short{}} = Shorts.delete_short(short)
      assert_raise Ecto.NoResultsError, fn -> Shorts.get_short!(short.id) end
    end

    test "change_short/1 returns a short changeset" do
      short = short_fixture()
      assert %Ecto.Changeset{} = Shorts.change_short(short)
    end
  end
end
