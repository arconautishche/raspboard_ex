defmodule RaspboardExWeb.LightsPanelLive do
  use RaspboardExWeb, :live_view

  alias Raspboard.LightsService
  alias Phoenix.PubSub

  import RaspboardWeb.LightComponents
  import Hue.Light

  @lights_service Raspboard.LightsService
  @pubsub Raspboard.PubSub
  @topic "lights:hue"

  def mount(_, _, socket) do
    if connected?(socket) do
      PubSub.subscribe(@pubsub, @topic)
    end

    {:ok, assign(socket, lights: get_lights_status())}
  end

  def handle_event("toggleLight", %{"lightid" => id}, socket) do
    current_light_state = socket.assigns.lights.reachable
    |> light_by_id(id)
    |> light_state()

    LightsService.toggle_light(@lights_service, id, !current_light_state)

    {:noreply, socket}
  end

  def handle_info(:lights_state_update, socket) do
    IO.puts "lights_state_update"

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
