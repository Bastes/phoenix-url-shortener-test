defmodule Shorty.Shorts.Short do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shorts" do
    field :hash_id, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(short, attrs) do
    short
    |> cast(attrs, [:hash_id, :url])
    |> validate_required([:hash_id, :url])
    |> unique_constraint(:hash_id)
    |> unique_constraint(:url)
  end
end
