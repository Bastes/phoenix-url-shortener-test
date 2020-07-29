defmodule ShortyWeb.ShortView do
  use ShortyWeb, :view

  def link_to_short(conn, short) do
    link_to Routes.page_url(conn, :to_full_url, short.hash_id)
  end

  def link_to(url) do
    link url, to: url
  end
end
