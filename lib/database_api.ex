defmodule DatabaseApi do
  @moduledoc """
  For all database api related methods and utility functions
  """

  @doc """
  Get a list of assets by ID.
  This function has semantics identical to get_objects
  """
  @api 0

  def get_assets(asset_ids) do
    call("get_assets", [asset_ids])
  end

  def list_assets(lower_bound, limit) do
    call("list_assets", [lower_bound, limit])
  end

  def call(method_name, method_params) do
     Graphene.call [@api, method_name, method_params]
  end

end
