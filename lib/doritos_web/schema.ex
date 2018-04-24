defmodule DoritosWeb.Schema do
  use Absinthe.Schema

  enum :server_status do
    description("The server's current status")

    value(:in_game, description: "A game is currently in-session")
    value(:in_lobby, description: "The server is currently at the menu screen")
    value(:loading, description: "The server is loading into a game")
  end

  object :server do
    @desc "The server's IP address"
    field(:ip, non_null(:string))

    @desc "The port in which the game server is on"
    field(:port, non_null(:integer))

    # @desc "The region in which the server is in"
    # field :region, :string

    @desc "The name of the server"
    field(:name, non_null(:string))

    @desc "The player hosting the server"
    field(:host_player, :string)

    @desc "Is sprint enabled?"
    field(:sprint_enabled, non_null(:boolean))

    @desc "Can you sprint endlessly?"
    field(:sprint_unlimited_enabled, non_null(:boolean))

    @desc "Can you dual wield?"
    field(:dual_wielding, non_null(:boolean))

    @desc "Are there assasination animations?"
    field(:assassination_enabled, non_null(:boolean))

    @desc "Can you vote on maps/mods after each game?"
    field(:voting_enabled, non_null(:boolean))

    @desc "Does this game mode require teams?"
    field(:teams, non_null(:boolean))

    @desc "The status of the server"
    field(:status, non_null(:server_status))

    @desc "The map being played"
    field(:map, :string)

    @desc "Do you need a password to join?"
    field(:passworded, non_null(:boolean))

    @desc "The filename of the map being played"
    field(:map_file, non_null(:string))

    # Don't know what these are yet lel
    field(:xnkid, non_null(:string))
    field(:xnaddr, non_null(:string))

    @desc "Game mode name"
    field(:variant_type, non_null(:string))

    @desc "Game mode"
    field(:variant, non_null(:string))

    @desc "Is the game server running on a dedicated server?"
    field(:is_dedicated, non_null(:boolean))

    @desc "The server's version of Halo Online"
    field(:game_version, non_null(:string))

    @desc "The server's version of El Dewrito"
    field(:eldewrito_version, non_null(:string))
  end

  query do
    @desc "Get all server data"
    field :all_servers, list_of(:server) do
      resolve(&DoritosWeb.Resolver.all_servers/3)
    end
  end
end
