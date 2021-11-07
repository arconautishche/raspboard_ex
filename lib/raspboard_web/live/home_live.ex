defmodule RaspboardWeb.HomeLive do
  use RaspboardWeb, :live_view

  alias RaspboardWeb.Components

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end


end
