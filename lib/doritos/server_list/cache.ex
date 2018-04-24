defmodule Doritos.ServerList.Cache do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: {:global, :server_list_cache})
  end

  def init(_state) do
    schedule()
    Task.start(__MODULE__, :get_server_list, [])
    {:ok, []}
  end

  def handle_info(:get_server_list, state) do
    schedule()
    Task.start(__MODULE__, :get_server_list, [])

    {:noreply, state}
  end

  def handle_call(:give_server_list, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:update_server_list, new_list}, _from, _state) do
    {:reply, new_list, new_list}
  end

  def get_server_list() do
    case HTTPoison.get("http://158.69.166.144:8080/list", timeout: 10_000) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        case Jason.decode(body) do
          {:ok, %{"result" => %{"servers" => server_list}}} ->
            Task.start(GenServer, :call, [
              {:global, :server_list_cache},
              {:update_server_list, server_list}
            ])

          _ ->
            {:error, "Could no get master server list"}
        end

      _ ->
        {:error, "Could not get master server list"}
    end
  end

  def schedule() do
    Process.send_after(self(), :get_server_list, 10_000)
  end
end
