defmodule RichComponentsDemoWeb.Components.TextEditor do
  use Surface.Component
  alias SurfaceRichComponents.TextEditor

  prop name, :atom, required: true
  prop value, :string
  prop label, :string
  prop class, :string
  prop debounce, :string, default: nil

  def render(assigns) do
    ~F"""
    <div>
      <div class="mt-4 mb-1 text-sm text-gray-700 dark:text-gray-400">{@label}</div>

      <div class="border border-gray-300 p-3 pt-2
          w-full mt-1 border-gray-300 rounded-lg shadow-sm bg-white
          focus-within:border-blue-300 focus-within:ring focus-within:ring-blue-200 focus-within:ring-opacity-50">
        <TextEditor
          name={@name}
          class="h-20 focus:outline-none prose prose-editor overflow-y-auto"
          btn_active_class="bg-gray-100 text-red-500"
          opts={phx_debounce: "1000"}
        />

        {!-- Toolbar --}
        <div data-editor-toolbar={@name} class="flex divide-x divide-gray-200 opacity-100">
          <div class="px-1">
            <button type="button" class="hover:bg-gray-100 rounded-md p-2" data-editor-control="h1">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                fill="currentColor"
                class="bi bi-type-h1"
                viewBox="0 0 16 16"
              >
                <path d="M8.637 13V3.669H7.379V7.62H2.758V3.67H1.5V13h1.258V8.728h4.62V13h1.259zm5.329 0V3.669h-1.244L10.5 5.316v1.265l2.16-1.565h.062V13h1.244z" />
              </svg>
            </button>
          </div>
          <div class="px-1">
            <button type="button" class="hover:bg-gray-100 rounded-md p-2" data-editor-control="bold">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                fill="currentColor"
                class="bi bi-type-bold"
                viewBox="0 0 16 16"
              >
                <path d="M8.21 13c2.106 0 3.412-1.087 3.412-2.823 0-1.306-.984-2.283-2.324-2.386v-.055a2.176 2.176 0 0 0 1.852-2.14c0-1.51-1.162-2.46-3.014-2.46H3.843V13H8.21zM5.908 4.674h1.696c.963 0 1.517.451 1.517 1.244 0 .834-.629 1.32-1.73 1.32H5.908V4.673zm0 6.788V8.598h1.73c1.217 0 1.88.492 1.88 1.415 0 .943-.643 1.449-1.832 1.449H5.907z" />
              </svg>
            </button>
            <button type="button" class="hover:bg-gray-100 rounded-md p-2" data-editor-control="italic">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                fill="currentColor"
                class="bi bi-type-italic"
                viewBox="0 0 16 16"
              >
                <path d="M7.991 11.674 9.53 4.455c.123-.595.246-.71 1.347-.807l.11-.52H7.211l-.11.52c1.06.096 1.128.212 1.005.807L6.57 11.674c-.123.595-.246.71-1.346.806l-.11.52h3.774l.11-.52c-1.06-.095-1.129-.211-1.006-.806z" />
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
