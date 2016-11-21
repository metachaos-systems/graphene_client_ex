# Elixir client for Bitshares/Graphene 2.0 websocket API

Provides an interface to Bitshares/ Graphene 2.0 JSONRPC protocol. Graphene_client_ex is a supervised application, so don't forget to add it to applications in mix.exs

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `graphene_client_ex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:graphene_client_ex, "~> 0.1.0"}]
    end
    ```

  2. Ensure `graphene_client_ex` is started before your application:

    ```elixir
    def application do
      [applications: [:graphene_client_ex]]
    end
    ```


## Example

First, add a websockets url for the graphene daemon, for example, `wss://bitshares.openledger.info/ws` to the config.

```elixir
    config :graphene_client_ex,
      url: "GRAPHENE_URL"
```

The most imporant module function is `Steemex.call`. It will block the calling process and return a success tuple with a "result" data from the JSONRPC call response. JSONRPC call ids are handled automatically.
