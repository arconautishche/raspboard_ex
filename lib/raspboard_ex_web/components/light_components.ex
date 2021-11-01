defmodule RaspboardWeb.LightComponents do
  use Phoenix.Component

  def light_switch(assigns) do
    ~H"""
    <div
      id={"wrapper-#{@id}"}
      class={"
        w-32
        border border-gray-600 border-opacity-20 rounded-lg
        bg-opacity-75
        shadow-md backdrop-blur
        flex flex-col justify-center place-items-end overflow-hidden
        cursor-pointer"}
      phx-click="toggleLight" phx-value-lightid={@id}
      >
      <div
          class={"h-24 w-full
            transition-all duration-500
            #{light_switch_classes(assigns)}
            pt-2"}
            >
          <div
              class={"w-full
                text-center text-gray-900 text-xl font-bold text-opacity-10"}
              style='transform: scale({$nameScale})'>

              <%= "#{@name}" %>
          </div>
      </div>
      <div
          class={"w-full h-5
            cursor-pointer
            border-t border-gray-400 border-opacity-25
            #{light_source_classes(assigns)}"}
          style='background: linear-gradient(90deg, {$lightSourceBgEdges} 0%, {$lightSourceBgMidPoint} 50%, {$lightSourceBgEdges} 100%)'
          class:light-source-on='{on}'>
      </div>

      </div>
    """
  end

  defp light_source_classes(%{on: true}) do
    "bg-yellow-200"
  end

  defp light_source_classes(%{on: false}) do
    "bg-gray-700"
  end

  defp light_switch_classes(%{on: true}) do
    "bg-gray-100"
  end

  defp light_switch_classes(%{on: false}) do
    "bg-gray-600"
  end

end
