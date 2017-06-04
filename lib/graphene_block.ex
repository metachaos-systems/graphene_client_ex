defmodule Graphene.Block do
  defstruct [:height, :transactions, :previous, :transactions_merkle_root, :witness, :witness_signature, :timestamp, :extensions]

  use ExConstructor
  
  def unpack_txs(block) do
    for tx <- block.transactions, do: tx
  end

end
