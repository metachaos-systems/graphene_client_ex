defmodule GrapheneTest do
  use ExUnit.Case
  doctest Graphene
  @db_api 0

  setup_all context do
    url = "wss://bitshares.openledger.info/ws"
    Graphene.RefStore.start_link
    Graphene.WS.start_link(url)
    %{
      params: %{get_accounts: [@db_api, "get_accounts", [["1.2.0"]]],
     }
    }
  end

  test "get_accounts", context do
    params = context.params.get_accounts
    {:ok, result} = Graphene.call(params)

    assert [%{"name" => "committee-account"}] = result
  end


end
