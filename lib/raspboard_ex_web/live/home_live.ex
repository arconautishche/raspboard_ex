defmodule RaspboardExWeb.HomeLive do
  use RaspboardExWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :tick, 1_000)

    {:ok, assign(socket, :temp, 42)}
  end

  @impl true
  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 1_000)

    {:noreply, assign(socket, :temp, socket.assigns.temp + 1)}
  end


end
