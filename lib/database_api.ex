defmodule DatabaseApi do
  @moduledoc """
  For all database api related methods and utility functions
  """

  @doc """
  Get a list of assets by ID.
  This function has semantics identical to get_objects
  """
  @api 0

  # BLOCKS
  @doc """
  Retrieve the current dynamic_global_property_object.
  """
  def get_dynamic_global_properties() do
     call "get_dynamic_global_properties", []
  end

  # ASSETS

  @doc """
  Get a list of assets by ID.
  """
  def get_assets(asset_ids) do
    call("get_assets", [asset_ids])
  end

  @doc """
  Get assets alphabetically by symbol name.
  """
  def list_assets(lower_bound, limit) do
    call("list_assets", [lower_bound, limit])
  end

  @doc """
  Get a list of assets by symbol.
  This function has semantics identical to get_objects
  Return
  The assets corresponding to the provided symbols or IDs
  Parameters
  asset_symbols -
  Symbols or stringified IDs of the assets to retrieve
  """
  def lookup_asset_symbols(symbols) do
    symbols = List.wrap(symbols)
    call("lookup_asset_symbols", [symbols])
  end

  # WITNESSES

  @doc """
  Get a list of witnesses by ID.
  This function has semantics identical to get_objects
  Return
  The witnesses corresponding to the provided IDs
  Parameters
  witness_ids -
  IDs of the witnesses to retrieve
  """
  def get_witnesses(ids) do
    ids = List.wrap(ids)
    call("get_witnesses", [ids])
  end

  @doc """
  Get the witness owned by a given account.
  Return
  The witness object, or null if the account does not have a witness
  Parameters
  account -
  The ID of the account whose witness should be retrieved
  """
  def get_witness_by_account(account) do
    call("get_witness_by_account", [account])
  end

  @doc """
  Get names and IDs for registered witnesses.
  Return
  Map of witness names to corresponding IDs
  Parameters
  lower_bound_name -
  Lower bound of the first name to return
  limit -
  Maximum number of results to return must not exceed 1000
  """
  def lookup_witness_accounts(lower_bound, limit) do
    call("lookup_witness_accounts",[lower_bound, limit])
  end

  # UTILITY
  def call(method_name, method_params) do
     Graphene.call [@api, method_name, method_params]
  end

end
