defmodule Doritos.Insight do
  def get_all_server_data() do
    Doritos.ServerData.Cache.get_all_data()
  end

  def get_active_player_count() do
  end

  def get_active_server_count() do
    Doritos.ServerData.Cache.get_all_data()
    |> Enum.count()
  end

  def get_server_data_by_ip(ip) do
    Doritos.ServerData.Cache.get_ip_data(ip)
  end

  # get_leaderboard_data
  # get_player_stat_data
end
