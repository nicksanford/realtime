defmodule Realtime.Workflows.PersistentExecutionWorker do
  use Oban.Worker, queue: :workflow_interpreter

  require Logger

  alias Realtime.Workflows.Manager
  alias Realtime.Workflows
  alias StateMachine.Interpreter

  @impl Oban.Worker
  def perform(%Oban.Job{args: args}) do
    workflow_id = args["workflow_id"]
    execution_id = args["execution_id"]
    arguments = args["arguments"]

    workflow = Manager.workflow_by_id(workflow_id)
    execution = Workflows.get_workflow_execution(execution_id)

    Interpreter.start_execution(workflow, execution)
    :ok
  end
end