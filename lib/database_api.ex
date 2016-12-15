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

  # UTILITY
  def call(method_name, method_params) do
     Graphene.call [@api, method_name, method_params]
  end

end
