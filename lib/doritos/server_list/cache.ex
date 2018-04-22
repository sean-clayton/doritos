defmodule Doritos.ServerList.Cache do
  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def init(_state) do
    schedule()
    {:ok, []}
  end

  def handle_info(:get_server_list, _state) do
    schedule()

    case get_server_list() do
      {:ok, server_list} -> {:noreply, server_list}
      {:error, _reason} -> {:noreply, []}
    end
  end

  def get_server_list() do
    case HTTPoison.get("http://158.69.166.144:8080/list") do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        case Jason.decode(body) do
          {:ok, %{"result" => %{"servers" => server_list}}} ->
            spawn_watchers(server_list)
            {:ok, server_list}

          _ ->
            {:error, "Could no get master server list"}
        end

      _ ->
        {:error, "Could not get master server list"}
    end
  end

  def spawn_watchers(server_list) do
    server_list
    |> Enum.each(fn ip_address ->
      GenServer.start_link(
        Doritos.ServerWatcher,
        %{ip: ip_address, data: nil},
        name: String.to_atom(ip_address)
      )
    end)

    :ok
  end

  def schedule() do
    Process.send_after(self(), :get_server_list, 5_000)
  end
end
