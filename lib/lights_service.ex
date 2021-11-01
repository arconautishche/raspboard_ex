defmodule Raspboard.LightsService do
  use GenServer

  # CLIENT

  def start_link(options) do
    GenServer.start_link(__MODULE__, retrieve_lights_status(), options)
  end

  def get_lights_status(pid) do
    GenServer.call(pid, :get_lights_status)
  end

  def toggle_light(pid, light_id, desired_state) do
    # TODO: validate light_id & desired_state
    GenServer.cast(pid, {:toggle_light, light_id, desired_state})
  end

  # SERVER

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_call(:get_lights_status, _from, _light_state) do
    updated_light_status = retrieve_lights_status()
    {:reply, updated_light_status, updated_light_status}
  end

  @impl true
  def handle_cast({:toggle_light, light_id, desired_state}, _lights_state) do
    case Hue.Client.set_light(light_id, desired_state) do
      {:ok} ->
        # TODO: pubsub: broadcast light state updated
        {:noreply, retrieve_lights_status()}
      _ ->
        {:noreply, retrieve_lights_status()}
    end
  end

  # PRIVATE

  defp retrieve_lights_status do
    case Hue.Client.get_lights() do
      {:ok, lights} -> lights
      _ -> []
    end
  end

end
