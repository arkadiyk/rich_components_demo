defmodule RichComponentsDemoWeb.Components.MultiSelectSector do
  use Surface.LiveComponent
  alias RichComponentsDemo.Gics

  alias SurfaceRichComponents.MultiSelect

  prop name, :atom, required: true

  data sectors, :list, default: []
  data industries, :list, default: []
  data filtered_industries, :list, default: []
  data selected_industries, :list, default: []

  @impl true
  def mount(socket) do
    sectors = Gics.list_sector() |> Map.new(&{&1.code, &1})
    industries = Gics.list_industry()
    selected = Enum.take_random(industries, 3)

    socket =
      socket
      |> assign(
        sectors: sectors,
        industries: industries,
        filtered_industries: industries,
        selected_industries: selected
      )

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~F"""
    <MultiSelect
      name={@name}
      filter="filter_sectors"
      select="select_sector"
      class="relative py-2 pl-3 pr-10 bg-white block mt-1 placeholder-gray-400 rounded-md shadow-sm border focus-within:ring focus-within:ring-opacity-50 border-gray-300 focus-within:border-blue-300 focus-within:ring-blue-200 transition duration-150 ease-in-out"
      focus_class="bg-gray-600 text-red-300"
    >
      <:input>
        <div class="w-full">
          <div class="flex">
            <div class="flex flex-auto flex-wrap">
              {#for ind <- @selected_industries}
                <div class="flex justify-center items-center m-1 font-medium py-1 px-2 bg-white rounded-full text-teal-700 bg-teal-100 border border-teal-300">
                  <div class="text-xs font-normal leading-none max-w-full flex-initial">{ind.code}</div>
                  <div class="flex flex-auto flex-row-reverse">
                    <div>
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="100%"
                        height="100%"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        class="feather feather-x cursor-pointer hover:text-teal-400 rounded-full w-4 h-4 ml-2"
                      >
                        <line x1="18" y1="6" x2="6" y2="18" />
                        <line x1="6" y1="6" x2="18" y2="18" />
                      </svg>
                    </div>
                  </div>
                </div>
              {/for}
              <div class="flex-1">
                <input
                  type="search"
                  data-select-input
                  style="box-shadow: none;"
                  class="border-none w-full h-full focus:outline-none"
                />
              </div>
              <span class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                <svg class="w-5 h-5 text-gray-400" viewBox="0 0 20 20" fill="none" stroke="currentColor">
                  <path
                    d="M7 7l3-3 3 3m0 6l-3 3-3-3"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
              </span>
            </div>
          </div>
        </div>
      </:input>

      {!-- section to display filtered option list --}
      <:dropdown>
        <div class="relative">
          <ul class="absolute list-none z-10 w-full mt-1 bg-white rounded-md shadow-lg py-1 overflow-auto text-base leading-6 rounded-md shadow-xs max-h-60 focus:outline-none sm:text-sm sm:leading-5">
            {#for {sector_code, industries} <- group_by_sector(@filtered_industries)}
              <li>
                <div class="flex justify-between text-lg bg-gray-200 px-3 py-1">
                  <div>
                    {@sectors[sector_code].name}
                  </div>
                  <div>
                    {sector_code}
                  </div>
                </div>
                <ul>
                  {#for industry <- industries}
                    <li
                      data-select-value={industry.code}
                      class="flex justify-between pl-6 pr-3 py-1 hover:bg-gray-100"
                    >
                      <div>
                        {industry.name}
                      </div>
                      <div>
                        {industry.code}
                      </div>
                    </li>
                  {/for}
                </ul>
              </li>
            {/for}
          </ul>
        </div>
      </:dropdown>
    </MultiSelect>
    """
  end

  @impl true
  def handle_event("filter_sectors", filter, socket) do
    %{industries: industries} = socket.assigns

    filtered_industries =
      Enum.filter(
        industries,
        &String.starts_with?(String.downcase(&1.name), String.downcase(filter))
      )

    {:noreply, assign(socket, filtered_industries: filtered_industries)}
  end

  @impl true
  def handle_event("select_sector", industry_code, socket) do
    %{industries: industries, selected_industries: selected_industries} = socket.assigns
    industry = Enum.find(industries, &(&1.code == industry_code))

    new_selected =
      cond do
        industry in selected_industries ->
          selected_industries

        true ->
          selected_industries ++ [industry]
      end

    {:noreply, assign(socket, selected_industries: new_selected, filtered_industries: industries)}
  end

  def group_by_sector(industries) do
    Enum.group_by(industries, & &1.sector_code)
  end
end
