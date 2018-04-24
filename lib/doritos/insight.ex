defmodule Doritos.Insight do
  def get_all_server_data() do
    GenServer.call({:global, :server_data_cache}, :give_cached_data)
  end

  def get_active_player_count() do
  end

  def get_active_server_count() do
  end

  def get_server_data_by_ip(_ip) do
  end

  # get_leaderboard_data
  # get_player_stat_data
end
