defmodule GrapheneTest do
  use ExUnit.Case, async: true
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

  test "get_block" do
    {:ok, result} = Graphene.get_block(1)
    assert %{"timestamp" => "2015-10-13T14:12:24"} = result
  end

  @tag :skip
  test "get_transaction" do
    {:ok, result} = Graphene.get_transaction(314,1)
    assert [] = result
  end


end
