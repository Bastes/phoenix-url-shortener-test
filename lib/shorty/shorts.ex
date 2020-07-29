defmodule Shorty.Shorts do
  @moduledoc """
  The Shorts context.
  """

  import Ecto.Query, warn: false
  alias Shorty.Repo

  alias Shorty.Shorts.Short

  @doc """
  Returns the list of shorts.

  ## Examples

      iex> list_shorts()
      [%Short{}, ...]

  """
  def list_shorts do
    Repo.all(Short)
  end

  def get_short!(hash_id) do
    Short
    |> Repo.get_by!(hash_id: hash_id)
  end

  @doc """
  Creates a short.

  ## Examples

      iex> create_short(%{field: value})
      {:ok, %Short{}}

      iex> create_short(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_short(attrs \\ %{}) do
    %Short{}
    |> Short.changeset(attrs)
    |> Repo.insert()
  end

  def create_short_from_url(attrs \\ %{}) do
    %Short{}
    |> Short.changeset(auto_generate_hash_id(attrs))
    |> Repo.insert()
  end

  def find_or_create_short_from_url(attrs \\ %{})
  def find_or_create_short_from_url(%{"url" => url} = attrs) when is_nil(url) do
    create_short_from_url(attrs)
  end
  def find_or_create_short_from_url(%{"url" => url} = attrs) do
    case Repo.get_by(Short, url: url) do
      nil ->
        create_short_from_url(attrs)
      short ->
        {:ok, short}
    end
  end

  def auto_generate_hash_id(%{"url" => url} = _attrs) do
    %{
      "url" => url,
      "hash_id" => new_hash()
    }
  end

  @hash_id_length 8
  def new_hash() do
    @hash_id_length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64
    |> binary_part(0, @hash_id_length)
  end

  @doc """
  Deletes a short.

  ## Examples

      iex> delete_short(short)
      {:ok, %Short{}}

      iex> delete_short(short)
      {:error, %Ecto.Changeset{}}

  """
  def delete_short(%Short{} = short) do
    Repo.delete(short)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking short changes.

  ## Examples

      iex> change_short(short)
      %Ecto.Changeset{data: %Short{}}

  """
  def change_short(%Short{} = short, attrs \\ %{}) do
    Short.changeset(short, attrs)
  end
end
