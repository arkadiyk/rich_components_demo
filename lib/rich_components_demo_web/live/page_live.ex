defmodule RichComponentsDemoWeb.PageLive do
  use Surface.LiveView
  alias Surface.Components.Form
  alias RichComponentsDemoWeb.Components.{TextEditor, SelectSector}

  defmodule FakeForm do
    defstruct [:message_text, :industry_code]
  end

  @impl true
  def mount(_params, _session, socket) do
    data = %FakeForm{industry_code: "451030", message_text: "<p>Old Message</p>"}
    types = %{industry_code: :string, message_text: :string}

    changeset =
      {data, types}
      |> Ecto.Changeset.cast(%{industry_code: "451030", message_text: ""}, [
        :industry_code,
        :message_text
      ])

    {:ok, assign(socket, changeset: changeset)}
  end

  @impl true
  def render(assigns) do
    ~F"""
      <div class="container m-auto p-20">
        <div class="prose mb-5">
          <h1 class="m-auto">Surface UI Rich Components Demo</h1>
          <p>Collection of <a href="https://github.com/arkadiyk/surface_rich_components">headless JS components</a> for <a href="https://surface-ui.org/">SurfaceUI framework</a></p>
        </div>

        <div class="shadow-2xl border-0 p-3">
          <Form
            for={@changeset}
            submit="save"
            change="validate"
            opts={autocomplete: "off"}
            class="pb-5 xl:w-1/2 lg:w-2/3 w-3/4 m-auto"
            phx_auto_recover="recover"
          >

            <div class="prose mt-7 mb-2">
              <h3 class="m-auto">Rich Editor</h3>
            </div>

            <TextEditor name={:message_text} label="Message" debounce="1000" />

            <div class="prose mt-7 mb-2">
              <h3 class="m-auto">Search Select</h3>
            </div>

            <SelectSector id="select-sector" name={:industry_code} />

            <div class="my-7">
              <button
                type="submit"
                class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:w-auto sm:text-sm"
              >
                Save
              </button>
            </div>
          </Form>
        </div>

        <div class="prose mt-20">
          <p>Source code of the library: <a href="https://github.com/arkadiyk/surface_rich_components">https://github.com/arkadiyk/surface_rich_components</a></p>
          <p>Source code of this demo: <a href="https://github.com/arkadiyk/rich_components_demo">https://github.com/arkadiyk/rich_components_demo</a></p>
        </div>
      </div>
    """
  end

  @impl true
  def handle_event("validate", %{"fake_form" => form_params}, socket) do
    IO.inspect(form_params, label: "VALIDATE")
    {:noreply, socket}
  end

  @impl true
  def handle_event("save", %{"fake_form" => form_params}, socket) do
    IO.inspect(form_params, label: "SAVE")
    {:noreply, socket}
  end
end
