defmodule RaspboardExWeb.LightsPanelLive do
  use RaspboardExWeb, :live_view

  alias Raspboard.LightsService

  import RaspboardWeb.LightComponents
  import Hue.Light

  @lights_service Raspboard.LightsService

  def mount(_, _, socket) do
    {:ok, assign(socket, lights: get_lights_status())}
  end

  def handle_event("toggleLight", %{"lightid" => id}, socket) do
    IO.puts "toggle light: #{id}"

    current_light_state = socket.assigns.lights.reachable
    |> light_by_id(id)
    |> light_state()

    LightsService.toggle_light(@lights_service, id, !current_light_state)

    {:noreply, assign(socket, lights: get_lights_status())}
  end

  defp get_lights_status do
    {reachable, unreachable} =
      LightsService.get_lights_status(@lights_service)
      |> Enum.split_with(fn l -> l.state.reachable end)

    %{
      reachable: reachable,
      unreachable: unreachable
    }
  end

end
