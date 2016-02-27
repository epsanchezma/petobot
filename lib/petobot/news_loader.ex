defmodule Petobot.NewsLoader do
  
  use HTTPoison.Base

  def get_random_new do
    news_url = "http://feeds.feedburner.com/TechCrunch/"
    message = HTTPoison.get!(news_url) |> parse_feed
  end

  defp parse_feed(xml_string) do
    feed = ElixirFeedParser.parse(xml_string)
    title = feed.title
    description = feed.description
    link = feed.link

    message = "Title: #{title} /n Description: #{description} /n Link: #{link}"
  end
end