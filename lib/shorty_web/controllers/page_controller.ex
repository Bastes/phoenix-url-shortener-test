defmodule ShortyWeb.PageController do
  use ShortyWeb, :controller

  alias Shorty.Shorts
  alias Shorty.Shorts.Short

  def index(conn, _params) do
    changeset = Shorts.change_short(%Short{})
    render(conn, "index.html", %{changeset: changeset})
  end

  def to_full_url(conn, %{"id" => id}) do
    short = Shorts.get_short!(id)
    redirect(conn, external: short.url)
  end
end
