defmodule Petobot do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
    	worker(Petobot.Slack, [], restart: :transient)
    ]

    opts = [strategy: :one_for_one, name: Petobot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
