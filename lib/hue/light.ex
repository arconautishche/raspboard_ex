defmodule Hue.Light do
  defstruct [:id, :name, :state]

  def light_by_id(all_lights, light_id) do
    all_lights
    |> Enum.find(fn l -> l.id == light_id end)
  end

  def light_state(%Hue.Light{} = light) do
    light
      |> Map.get(:state)
      |> Map.get(:on)
  end
end
