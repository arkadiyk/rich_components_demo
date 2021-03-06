[
  import_deps: [:ecto, :phoenix, :surface],
  inputs: [
    "{mix,.formatter}.exs",
    "{config,lib,test}/**/*.{ex,exs}",
    "priv/catalogue/**/*.{ex,exs}"
  ],
  surface_inputs: [
    "{lib,test}/**/*.{ex,exs,sface}",
    "priv/catalogue/**/*.{ex,exs,sface}"
  ]
]
