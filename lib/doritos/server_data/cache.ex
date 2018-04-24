defmodule Doritos.ServerData.Cache do
  use GenServer
  import Logger

  @table :doritos_server_data_cache

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_new_data_response(res = {:ok, %{request_url: request_url, body: body}}) do
    json = Jason.decode!(body)
    :ets.insert(@table, {request_url, json})
    res
  end

  def handle_new_data_response(res = {:error, ip, _data}) do
    debug("[ERR] #{ip}")
    :ets.delete(@table, ip)

    res
  end

  def get_ip_data(ip) do
    :ets.lookup(@table, ip)
  end

  def get_all_data do
    :ets.tab2list(@table)
  end

  def init(_) do
    :ets.new(@table, [
      :set,
      :named_table,
      :public,
      read_concurrency: true,
      write_concurrency: true
    ])

    {:ok, %{}}
  end
end
