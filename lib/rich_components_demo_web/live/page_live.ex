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
