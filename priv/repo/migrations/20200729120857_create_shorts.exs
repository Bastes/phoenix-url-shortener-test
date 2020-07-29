defmodule Shorty.Repo.Migrations.CreateShorts do
  use Ecto.Migration

  def change do
    create table(:shorts) do
      add :hash_id, :string
      add :url, :string

      timestamps()
    end

    create unique_index(:shorts, [:hash_id])
    create unique_index(:shorts, [:url])
  end
end
