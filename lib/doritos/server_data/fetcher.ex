defmodule Doritos.ServerData.Fetcher do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: {:global, :server_data_cache})
  end

  def init(state) do
    schedule()
    {:ok, state}
  end

  def handle_info(:update_cache, _state) do
    schedule()

    server_list = GenServer.call({:global, :server_list_cache}, :give_server_list)
    # server_list = ["http://158.69.166.144:8080/list"]

    update_cache(server_list)

    {:noreply, nil}
  end

  def handle_call(:give_cached_data, _from, state) do
    {:reply, state, state}
  end

  def update_cache(server_list) do
    # updated_at = DateTime.to_iso8601(DateTime.utc_now())
    # new_cache =
    server_list
    |> IO.inspect()
    |> Task.async_stream(
      fn ip ->
        HTTPoison.get(ip, timeout: 1_000)
      end,
      timeout: :infinity
    )
    |> Enum.each(&IO.inspect/1)

    # |> Stream.filter(&match?({:ok, %HTTPoison.Response{status_code: 200}}, &1))

    # |> Enum.map(fn {task, res} ->
    #   res || Task.shutdown(task)
    # end)
    # |> Enum.filter(fn task_res ->
    #   case task_res do
    #     {:ok, {:ok, %HTTPoison.Response{status_code: 200}}} -> true
    #     _ -> false
    #   end
    # end)
    # |> Enum.map(fn res ->
    #   {:ok, {:ok, http_res = %HTTPoison.Response{status_code: 200}}} = res
    #   http_res
    # end)
    # |> Enum.reduce(%{}, fn res, acc ->
    #   ip = res.request_url
    #   {:ok, body} = Jason.decode(res.body)

    #   acc |> Map.put(ip, body)
    # end)

    {:ok, nil}
  end

  def schedule() do
    Process.send_after(self(), :update_cache, 3_000)
  end
end
