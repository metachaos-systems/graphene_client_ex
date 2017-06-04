defmodule Graphene.Stage.Supervisor do
  use Supervisor
  alias Graphene.Stage

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: Graphene.Stage.Supervisor)
  end

  def init(:ok) do
    children = [
      worker(Graphene.Stage.Blocks.Producer, [[], [name: Stage.Blocks.Producer]]),
      # worker(Graphene.Stage.Blocks.ExampleConsumer, [[subscribe_to: [Stage.Blocks.Producer]]])
    ]
    supervise(children, strategy: :one_for_all)
  end

end
