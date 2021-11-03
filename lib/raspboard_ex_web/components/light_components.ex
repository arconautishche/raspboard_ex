defmodule RaspboardWeb.LightComponents do
  use Phoenix.Component

  def light_switch(assigns) do
    ~H"""
    <div
      id={"light-switch-#{@id}"}
      class={"
        w-32
        border border-gray-600 border-opacity-20 rounded-lg
        bg-opacity-75
        shadow-md backdrop-blur
        flex flex-col justify-center place-items-end overflow-hidden
        cursor-pointer"}
      {phx_click_attrs(assigns)}
      >
        <div
            class={"h-24 w-full
              transition-all duration-500
              #{classes(assigns).switch}
              pt-2"}
              >
            <div
                class={"w-full
                  text-center #{classes(assigns).name} text-xl font-bold text-opacity-20"}>

                <%= "#{@name}" %>
            </div>
        </div>
        <div
            class={"w-full h-5
              cursor-pointer
              border-t border-gray-400 border-opacity-25
              #{classes(assigns).source}
              transition-all duration-200"}
            style='background: linear-gradient(90deg, {$lightSourceBgEdges} 0%, {$lightSourceBgMidPoint} 50%, {$lightSourceBgEdges} 100%)'>
        </div>

      </div>
    """
  end

  defp classes(%{on: true}) do
    %{
      source: "bg-yellow-200",
      switch: "bg-yellow-50",
      name: "text-gray-800"
    }
  end

  defp classes(%{on: false}) do
    %{
      source: "bg-gray-700",
      switch: "bg-gray-600",
      name: "text-white"
    }
  end

  defp phx_click_attrs(%{disabled: true}) do
    %{}
  end

  defp phx_click_attrs(%{id: id}) do
    %{"phx-click": "toggleLight", "phx-value-lightid": id}
  end

end
