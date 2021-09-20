defmodule SurfaceRichComponents.MultiSelect do
  use Surface.Component

  alias Surface.Components.Form.{FieldContext, Input.InputContext}

  @doc "Changeset field name"
  prop name, :atom, required: true

  @doc "Additional input options like `phx_debounce`"
  prop opts, :keyword, default: []

  @doc "Triggered when `Search Input` is updated"
  prop filter, :event, required: true

  @doc "Triggered when the value is selected."
  prop select, :event, required: true

  @doc """
  **Search Input.**
  The `search` slot is shown when user clicks on element or presses Enter.
  It triggers `filter` event every time the Input is updated.
  It is hidden when value is selected.
  """
  slot input, required: true

  @doc """
  **Dropdown.** Appears when user click or press Enter on the component. Contains list of selectable elements.
  """
  slot dropdown, required: true

  @doc "Class for arrow selected rows"
  prop focus_class, :string

  prop class, :css_class

  defp generate_hiddens(form, field_name) do
    %{id: id, data: data} = form
    values = Map.get(data, field_name, [])
    Enum.map(values, &{"#{id}[#{field_name}][]", &1}) |> IO.inspect(label: "-----------")
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~F"""
    <div
      id={"rich-select-#{@name}"}
      :hook="MultiSelectHook"
      data-filter-target={@filter.target}
      data-filter-change={@filter.name}
      data-select-target={@select.target}
      data-select-change={@select.name}
      data-focus-class={@focus_class}
    >
      <div data-toggle-visibility aria-expanded="open" aria-haspopup="listbox" class={@class}>
        <div>
          <#slot name="input" />
        </div>
      </div>
      <div data-list-container style="display: none;">
        <#slot name="dropdown" />
      </div>
      <div>
        <InputContext assigns={assigns} :let={form: form}>
          {#for {name, value} <- generate_hiddens(form, @name)}
            <input type="text" name={name} value={value} />
          {/for}
        </InputContext>
      </div>
    </div>
    """
  end
end
