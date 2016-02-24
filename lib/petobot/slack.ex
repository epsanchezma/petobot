defmodule Petobot.Slack do
  use Slack

  @token Application.get_env(:petobot, __MODULE__)[:token]

  def start_link, do: start_link(@token, [])

  def handle_message(message = %{type: "message", text: text, user: user}, slack, state) do

    if Regex.match?(~r([<@#{slack.me.id}>:? [H|h]ello), text) do
      Slack.send_message("Hello #{user}!", message.channel, slack)
    end

    {:ok, state}
  end
  def handle_message(_message, _slack, state), do: {:ok, state}

end