# Elixir client for Graphene websocket API

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
