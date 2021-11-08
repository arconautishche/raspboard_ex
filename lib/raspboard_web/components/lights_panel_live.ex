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
    current_light_state = socket.assigns.groups_with_lights
    |> Enum.flat_map(&(&1.reachable_lights))
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
      groups_with_lights: all_light_groups |> only_with_reachable_lights,
      unreachable: all_light_groups |> Enum.flat_map(&(&1.unreachable_lights))
      )
  end

  defp only_with_reachable_lights(light_groups) do
    light_groups
    |> Enum.filter(&(!Enum.empty?(&1.reachable_lights)))
  end



end
