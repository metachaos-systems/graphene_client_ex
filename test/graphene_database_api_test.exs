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

  test "get_dynamic_global_properties" do
    {:ok, result} = Graphene.get_dynamic_global_properties()
    assert %{"head_block_id" => _, "head_block_number" => _, "id" => _, } = result
  end

  test "get_assets " do
     {:ok, result} = Graphene.get_assets(["1.3.241"])
     assert %{"symbol" => "BTSBOTS"} = hd(result)
  end

  test "list_assets " do
     {:ok, result} = Graphene.list_assets("BTS", 10)
     assert is_list(result)
     assert Enum.find(result, :nil, &(&1["symbol"] == "BTSBOTS"))["id"] == "1.3.241"
  end
end
