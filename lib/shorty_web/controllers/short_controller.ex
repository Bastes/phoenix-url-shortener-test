defmodule ShortyWeb.ShortController do
  use ShortyWeb, :controller

  alias Shorty.Shorts
  alias Shorty.Shorts.Short

  def index(conn, _params) do
    shorts = Shorts.list_shorts()
    render(conn, "index.html", shorts: shorts)
  end

  def new(conn, _params) do
    changeset = Shorts.change_short(%Short{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"short" => short_params}) do
    case Shorts.create_short(short_params) do
      {:ok, short} ->
        conn
        |> put_flash(:info, "Short created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    short = Shorts.get_short!(id)
    render(conn, "show.html", short: short)
  end

  def delete(conn, %{"id" => id}) do
    short = Shorts.get_short!(id)
    {:ok, _short} = Shorts.delete_short(short)

    conn
    |> put_flash(:info, "Short deleted successfully.")
    |> redirect(to: Routes.short_path(conn, :index))
  end
end
