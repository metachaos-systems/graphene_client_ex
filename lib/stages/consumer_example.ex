defmodule Graphene.Stage.Blocks.ExampleConsumer do
  use GenStage
  require Logger
  alias Graphene.Block

  def start_link(args, options \\ []) do
    GenStage.start_link(__MODULE__, args, options)
  end

  def init(args) do
    {:consumer, args, subscribe_to: args[:subscribe_to]}
  end

  def handle_events(events, _from, state) do
    block = hd(events)
    for tx <- Block.unpack_txs(block) do
      Logger.info """
      New transaction:
      #{inspect tx}
      """
    end
    {:noreply, [], state}
  end

end
