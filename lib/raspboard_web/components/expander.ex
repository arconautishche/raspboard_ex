defmodule RaspboardWeb.Components.Expander do
  use Phoenix.Component

  def expander(assigns) do
    # TODO: extract classes to props instead of hardcoding them here

    ~H"""
    <div x-data="{ open: false }"
        class="mt-5 rounded-lg
                bg-gray-900 bg-opacity-10">
        <div @click="open = !open"
            class="
                text-gray-500 cursor-pointer
                px-5 py-2
                rounded-lg
                hover:bg-gray-100 hover:bg-opacity-25" >
            <%= render_slot(@header) %>
        </div>
        <div x-show="open" x-transition>
            <%= render_slot(@body) %>
        </div>
    </div>
    """
  end
end
