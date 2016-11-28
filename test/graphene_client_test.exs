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

  test "get_chain_properties" do
    {:ok, result} = Graphene.get_chain_properties()
    assert %{"chain_id" => "4018d7844c78f6a6c41c6a552b898022310fc5dec06da467ee7905a8dad512c8"} = result
  end

  test "get_global_properties" do
    {:ok, result} = Graphene.get_global_properties()
    assert %{"parameters"  => %{}} = result
  end

  test "get_account_by_name" do
    {:ok, result} = Graphene.get_account_by_name("dan")
    assert %{"id" => "1.2.309"} = result
  end

  test "get_account_references" do
    {:ok, result} = Graphene.get_account_references("1.2.309")
    assert ["1.2.102338"] = result
  end

  test "lookup_account_names" do
    {:ok, result} = Graphene.lookup_account_names("1.2.309")
    assert ["1.2.102338"] = result
  end

  test "lookup_accounts" do
    {:ok, result} = Graphene.lookup_accounts("fractal", 3)
    assert [["fractalist5", "1.2.117491"], ["fractaln0de", "1.2.138432"],
      ["fractalnode-blockpay-tr", "1.2.133034"]] = result
  end

  test "get_account_count" do
    {:ok, result} = Graphene.get_account_count()
    assert result > 1337
  end

  # Balances

  test "get_account_balances without assets ids" do
    {:ok, result} = Graphene.get_account_balances("1.2.309")
    assert  %{"amount" => _, "asset_id" => _}  = hd(result)
  end

  test "get_account_balances with assets ids" do
    {:ok, result} = Graphene.get_account_balances("1.2.309", ["1.3.121"])
    assert %{"amount" => _, "asset_id" => "1.3.121"}  = hd(result)
  end

  test "get_named_account_balances without assets ids" do
    {:ok, result} = Graphene.get_named_account_balances("dan")
    assert  %{"amount" => _, "asset_id" => _}  = hd(result)
  end

  test "get_named_account_balances with asset ids" do
    {:ok, result} = Graphene.get_named_account_balances("dan", ["1.3.121"])
    assert %{"amount" => _, "asset_id" => "1.3.121"}  = hd(result) # FIXME
  end

  @tag :skip
  test "get_balance_objects with asset ids" do
    {:ok, result} = Graphene.get_balance_objects() # FIXME what are the right adresses for this call?
    assert %{}  = result
  end

  test "get_vested_balances" do
     {:ok, result} = Graphene.get_vested_balances(["1.15.0"])
     assert [%{"amount" => _, "asset_id" => "1.3.0"}] = result
  end

  test "get_vesting_balances" do
     {:ok, result} = Graphene.get_vesting_balances("1.2.309")
     assert %{"balance" => %{"amount" =>_}} = hd(result)
  end



end
