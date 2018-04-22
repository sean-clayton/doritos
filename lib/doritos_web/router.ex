defmodule DoritosWeb.Router do
  use DoritosWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DoritosWeb do
    pipe_through :api
  end
end
