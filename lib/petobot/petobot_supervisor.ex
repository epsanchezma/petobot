defmodule Petobot.SlackSupervisor do
  require Logger
  use Supervisor

  def start_link do
    Logger.info "Starting Slack Supervisor..."
    Supervisor.start_link(__MODULE__, [], [name: :slack_sup])
  end

  def init(_) do
    children = [
      worker(Petobot.Slack, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
