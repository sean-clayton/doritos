defmodule DoritosWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  enum :server_status do
    description("The server's current status")

    value(:in_game, description: "A game is currently in-session")
    value(:in_lobby, description: "The server is currently at the menu screen")
    value(:loading, description: "The server is loading into a game")
  end

  enum :variant_type do
    description("Type of game")

    value(:none)
    value(:vip)
    value(:oddball)
    value(:ctf)
    value(:koth)
    value(:forge)
    value(:slayer)
    value(:infection)
    value(:juggernaut)
    value(:assault)
  end

  # enum :sort_option do
  #   value(:number_of_players)
  #   value(:variant_type)
  #   value(:dedicated)
  # end

  # enum :sort_direction do
  #   value(:asc)
  #   value(:desc)
  # end

  input_object :iteration_options do
    # @desc "What to sort by"
    # field(:sort_by, :sort_option)

    # @desc "Direction to sort. Defaults to DESCENDING."
    # field(:sort_direction, :sort_direction)

    @desc "Index to start getting items from. Defaults to 0."
    field(:cursor, non_null(:integer))

    @desc "Number of items to get after the cursor. Defaults to 25."
    field(:length, non_null(:integer))
  end

  object :server do
    @desc "The last updated time for this server"
    field(:cached_at, non_null(:datetime))

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
    field(:voting_enabled, :boolean)

    @desc "Does this game mode require teams?"
    field(:teams, :boolean)

    @desc "The number of players currently in-game"
    field(:num_players, :integer)

    @desc "The maximum allowed players in the server"
    field(:max_players, :integer)

    @desc "The status of the server"
    field(:status, non_null(:server_status))

    @desc "The map being played"
    field(:map, :string)

    @desc "Do you need a password to join?"
    field(:passworded, :boolean)

    @desc "The filename of the map being played"
    field(:map_file, non_null(:string))

    @desc "Game mode name"
    field(:variant_type, :variant_type)

    @desc "Game mode"
    field(:variant, non_null(:string))

    @desc "Is the game server running on a dedicated server?"
    field(:is_dedicated, :boolean)

    @desc "The server's version of Halo Online"
    field(:game_version, non_null(:string))

    @desc "The server's version of El Dewrito"
    field(:eldewrito_version, non_null(:string))
  end

  query do
    @desc "Get all server data"
    field :all_servers, list_of(:server) do
      arg(:iteration_options, :iteration_options)
      resolve(&DoritosWeb.Resolver.all_servers/3)
    end
  end
end
