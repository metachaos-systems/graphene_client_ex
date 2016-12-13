defmodule GrapheneDatabaseApiTest do
  use ExUnit.Case, async: true
  doctest Graphene
  @db_api 0

  setup_all context do
    url = "wss://bitshares.openledger.info/ws"
    Graphene.IdStore.start_link
    Graphene.WS.start_link(url)
    {:ok, []}
  end

  test "get_assets " do
     {:ok, result} = Graphene.get_assets([""])
     assert %{"balance" => %{"amount" =>_}} = hd(result)
  end

  test "list_assets " do
     {:ok, result} = Graphene.list_assets("BTS", 10)
     assert is_list(result)
     assert Enum.find(result, :nil, &(&1["symbol"] == "BTSBOTS"))["id"] == "1.3.241"
  end
end
