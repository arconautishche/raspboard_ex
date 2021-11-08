defmodule RaspboardWeb.Components.LightsPanelLive do
  use RaspboardWeb, :live_view

  alias Raspboard.LightsService
  alias Phoenix.PubSub

  import RaspboardWeb.LightComponents
  import Hue.Light

  @lights_service Raspboard.LightsService
  @pubsub Raspboard.PubSub
  @topic "lights:hue"

  @impl true
  def mount(_, _, socket) do
    if connected?(socket) do
      PubSub.subscribe(@pubsub, @topic)
    end

    {:ok, socket |> with_lights_info}
  end

  @impl true
  def handle_event("toggleLight", %{"lightid" => id}, socket) do
    current_light_state = socket.assigns.lights.reachable
    |> light_by_id(id)
    |> light_state()

    LightsService.toggle_light(@lights_service, id, !current_light_state)

    {:noreply, socket}
  end

  @impl true
  def handle_info(:lights_state_update, socket) do
    IO.puts "lights_state_update"

    {:noreply, socket |> with_lights_info}
  end

  defp with_lights_info(socket) do
    all_light_groups = LightsService.get_lights_status(@lights_service)
    assign(
      socket,
      groups_with_lights: all_light_groups |> Enum.filter(fn gr -> !Enum.empty?(gr.reachable_lights) end),
      unreachable: all_light_groups |> Enum.flat_map(fn gr -> gr.unreachable_lights end)
      )
  end



end
