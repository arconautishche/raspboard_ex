defmodule Hue.Group do
  defstruct [:id, :name, :lights]

  def from_map({id, %{name: name, lights: lights}}) do
    %Hue.Group{
      id: id,
      name: name,
      lights: lights
    }
  end
end
