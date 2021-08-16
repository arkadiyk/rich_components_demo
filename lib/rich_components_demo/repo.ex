defmodule RichComponentsDemo.Repo do
  use Ecto.Repo,
    otp_app: :rich_components_demo,
    adapter: Ecto.Adapters.Postgres
end
