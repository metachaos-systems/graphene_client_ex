defmodule Graphene do
  use Application
  alias Graphene.{RefStore, WS}

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    url = Application.get_env(:graphene_client_ex, :url)

    unless url, do: throw("Graphene WS url is NOT configured.")

    # Define workers and child supervisors to be supervised
    children = [
      worker(Graphene.RefStore, []),
      worker(Graphene.WS, [url])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Graphene.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def call(params) do
    id = gen_id()
    RefStore.put(id, {self(), params})
    send_jsonrpc_call(id, params)

    response = receive do
      {:ws_response, {_, _, response}} -> response
    end

    case response["error"] do
      nil -> {:ok, response["result"]}
      _ -> {:error, response["error"]}
    end
  end

  @doc """
    Sends an event to the WebSocket server
  """
  defp send_jsonrpc_call(id, params) do
    send Graphene.WS, {:send, %{jsonrpc: "2.0", id: id, params: params, method: "call"}}
  end

  defp gen_id do
    round(:rand.uniform * 1.0e16)
  end

end
