defmodule Petobot.Slack do
  use Slack
  use GenServer
  alias Petobot.NewsLoader
  require Logger

  @token Application.get_env(:petobot, __MODULE__)[:token]

  def start(channel, params \\ %{}) do
    Supervisor.start_child(:slack_sup, [channel, params])
  end

  def start_link, do: start_link(@token, [])

  def handle_message(message = %{type: "message", text: text, user: user}, slack, state) do
    if Regex.match?(~r([<@#{slack.me.id}>:? [H|h]ello), text) do
      Slack.send_message("Hello #{user}!", message.channel, slack)
    end

    new = NewsLoader.get_random_new

    if Regex.match?(~r([<@#{slack.me.id}>:? [N|n]ews), text) do
      Slack.send_message(new, message.channel, slack)
    end

    {:ok, state}
  end
  def handle_message(_message, _slack, state), do: {:ok, state}

end