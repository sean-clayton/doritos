defmodule DoritosWeb.Resolver do
  alias Doritos.Insight

  def all_servers(_root, args, _info) do
    data =
      Insight.get_all_server_data()
      |> apply_iteration_options(args)
      |> Enum.map(&format_cached_server/1)

    {:ok, data}
  end

  defp apply_iteration_options(server_data, args) do
    %{cursor: cursor, length: length} =
      case args do
        %{iteration_options: iteration_options} -> iteration_options
        _ -> %{cursor: 0, length: 25}
      end

    server_data
    |> Enum.slice(cursor, length)
  end

  defp format_cached_server({url, data = %{}}) do
    data
    |> Map.put("ip", url |> URI.parse() |> Map.get(:host))
    |> convert_camelcase_to_snakecase
    |> string_keys_to_atoms
    |> convert_status
    |> convert_variant_type
    |> convert_booleans
  end

  def convert_variant_type(map = %{variant_type: variant_type}) do
    variant_type =
      case variant_type do
        "none" -> :none
        "oddball" -> :oddball
        "ctf" -> :ctf
        "koth" -> :koth
        "forge" -> :forge
        "slayer" -> :slayer
        "infection" -> :infection
        "juggernaut" -> :juggernaut
        "assault" -> :assault
        "vip" -> :vip
      end

    map
    |> Map.put(:variant_type, variant_type)
  end

  def convert_booleans(map = %{}) do
    assassination_enabled = Map.get(map, :assassination_enabled) || "0"
    dual_wielding = Map.get(map, :dual_wielding) || "0"
    sprint_enabled = Map.get(map, :sprint_enabled) || "0"
    sprint_unlimited_enabled = Map.get(map, :sprint_unlimited_enabled) || "0"
    passworded = Map.get(map, :passworded) || false

    map
    |> Map.put(:assassination_enabled, assassination_enabled |> string_num_to_boolean)
    |> Map.put(:dual_wielding, dual_wielding |> string_num_to_boolean)
    |> Map.put(:sprint_enabled, sprint_enabled |> string_num_to_boolean)
    |> Map.put(:sprint_unlimited_enabled, sprint_unlimited_enabled |> string_num_to_boolean)
    |> Map.put(:passworded, passworded)
  end

  def string_num_to_boolean(string) do
    case string do
      "1" -> true
      _ -> false
    end
  end

  def convert_camelcase_to_snakecase(map) do
    IO.inspect(map)
    for {key, val} <- map, into: %{}, do: {Macro.underscore(key), val}
  end

  defp convert_status(server = %{status: status}) do
    status =
      case status do
        "InLobby" -> :in_lobby
        "Loading" -> :loading
        "InGame" -> :in_game
      end

    server
    |> Map.put(:status, status)
  end

  defp string_keys_to_atoms(map = %{"players" => players}) when is_list(players) do
    map = for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}

    formatted_players =
      map.players
      |> Enum.map(&convert_camelcase_to_snakecase/1)
      |> Enum.map(&string_keys_to_atoms/1)

    map |> Map.put(:players, formatted_players)
  end

  defp string_keys_to_atoms(map = %{}) do
    for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}
  end
end
