defmodule Doritos.ServerData.Fetcher do
  use GenServer
  import Logger

  def start_link() do
    GenServer.start_link(__MODULE__, true, name: {:global, :server_data_cache})
  end

  def init(state) do
    schedule()
    {:ok, state}
  end

  def handle_info(:update_cache, state) do
    schedule()

    server_list = GenServer.call({:global, :server_list_cache}, :give_server_list)

    debug("Atemping to fetch more servers...")

    case state do
      true ->
        debug("Able to fetch servers, starting...")
        Task.start(__MODULE__, :update_cache, [server_list])
        {:noreply, false}

      false ->
        debug("Still currently getting data from servers, not fetching more.")
        {:noreply, false}
    end
  end

  def handle_cast(:update_done, _state) do
    debug("Done fetching servers")
    {:noreply, true}
  end

  def handle_call(:give_cached_data, _from, state) do
    {:reply, state, state}
  end

  def update_cache([]) do
    debug("Server list is empty...")
    send_update_done_signal()
  end

  def update_cache(server_list) do
    debug("We have servers. Fetching...")

    fetch_servers(server_list)

    {:ok, true}
  end

  def fetch_servers(server_list) do
    server_list
    |> MapSet.new()
    |> Flow.from_enumerable()
    |> Flow.partition()
    |> Flow.map(fn url ->
      case HTTPoison.get(url, timeout: 500) do
        res = {:ok, %HTTPoison.Response{status_code: 200}} -> res
        res -> {:error, url, res}
      end
    end)
    |> Flow.map(&Doritos.ServerData.Cache.handle_new_data_response/1)
    |> Flow.run()

    send_update_done_signal()
  end

  defp send_update_done_signal() do
    GenServer.cast({:global, :server_data_cache}, :update_done)
  end

  def schedule() do
    Process.send_after(self(), :update_cache, 3_000)
  end
end
