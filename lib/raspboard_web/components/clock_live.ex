defmodule RaspboardWeb.Components.ClockLive do
  use RaspboardWeb, :live_view

  @impl true
  def mount(_args, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :tick, 500)

    {
      :ok,
      socket
      |> update_clock
      |> update_colon_state
    }
  end

  @impl true
  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 500)

    {
      :noreply,
      socket
      |> update_clock
      |> update_colon_state
    }
  end

  def colon_classes(:colon_on) do
    "opacity-100"
  end

  def colon_classes(:colon_off) do
    "opacity-10"
  end


  defp update_clock(socket) do
    {{year, month, day}, {hour, min, sec}} = :calendar.local_time
    assign(socket,
      year: year,
      month: month |> with_leading_zero,
      day: day |> with_leading_zero,
      hour: hour |> with_leading_zero,
      min: min |> with_leading_zero,
      sec: sec |> with_leading_zero)
  end

  defp update_colon_state(%{assigns: %{colon_state: :colon_off}} = socket) do
    colon_state = :colon_on
    assign(socket, colon_state: colon_state)
  end

  defp update_colon_state(%{assigns: %{colon_state: :colon_on}} = socket) do
    colon_state = :colon_off
    assign(socket, colon_state: colon_state)
  end

  defp update_colon_state(socket) do
    colon_state = :colon_on
    assign(socket, colon_state: colon_state)
  end

  defp with_leading_zero(int) do
    int |> Integer.to_string |> String.pad_leading(2, "0")
  end
end
