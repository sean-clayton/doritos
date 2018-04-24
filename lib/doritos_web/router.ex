defmodule DoritosWeb.Router do
  use DoritosWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/" do
    pipe_through(:api)
    forward("/graphql", Absinthe.Plug, schema: DoritosWeb.Schema)

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: DoritosWeb.Schema,
      interface: :playground,
      socket: DoritosWeb.UserSocket
    )
  end

  scope "/api", DoritosWeb do
    pipe_through(:api)
  end
end
