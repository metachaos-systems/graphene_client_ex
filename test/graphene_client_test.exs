defmodule GrapheneTest do
  use ExUnit.Case
  doctest Graphene
  @db_api 0

  setup_all context do
    url = "wss://bitshares.openledger.info/ws"
    Graphene.IdStore.start_link
    Graphene.WS.start_link(url)
    %{
      params: %{get_accounts: [@db_api, "get_accounts", [["1.2.0"]]],
     }
    }
  end

  test "call get_accounts params", context do
    params = context.params.get_accounts
    {:ok, result} = Graphene.call(params)

    assert [%{"name" => "committee-account"}] = result
  end

  test "get_accounts" do
    {:ok, result} = Graphene.get_accounts(["1.2.0"])
    assert [%{"name" => "committee-account"}] = result
  end




end
