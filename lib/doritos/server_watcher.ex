defmodule Doritos.ServerWatcher do
  use GenServer

  def child_spec(_) do
    %{
      id: __MODULE__,
      restart: :temporary,
      shutdown: :brutal_kill
    }
  end

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def init(state) do
    schedule()

    case get_server_info(state.ip) do
      {:ok, data} -> {:ok, %{ip: state.ip, data: data}}
      {:error, _reason} -> {:ok, state}
    end
  end

  def handle_info(:get_server_info, state) do
    schedule()

    case get_server_info(state.ip) do
      {:ok, data} -> {:noreply, %{ip: state.ip, data: data}}
      {:error, _reason} -> {:noreply, state}
    end
  end

  def get_server_info(ip) do
    case HTTPoison.get(ip) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        case Jason.decode(body) do
          {:ok, data} ->
            {:ok, data}

          _ ->
            {:error, "Could not get data from #{ip}"}
        end

      _ ->
        {:error, "Could not get data from #{ip}"}
    end
  end

  def schedule() do
    Process.send_after(self(), :get_server_info, 3_000)
  end
end
