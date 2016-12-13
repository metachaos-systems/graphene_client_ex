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
     {:ok, result} = Graphene.get_assets(["1337"])
     assert %{"balance" => %{"amount" =>_}} = hd(result)
  end
end
