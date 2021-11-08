defmodule Hue.Light do
  defstruct [:id, :name, :state]

  def from_map({ id, details }) do
    %Hue.Light{
      id: Atom.to_string(id),
      name: details.name,
      state: details.state
    }
  end

  def light_by_id(lights, light_id) do
    lights
    |> Enum.find(fn l -> l.id == light_id end)
  end

  def light_state(%Hue.Light{} = light) do
    light
      |> Map.get(:state)
      |> Map.get(:on)
  end
end
