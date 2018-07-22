# frozen_string_literal: true

require 'http'

require_relative '../models/models'

module Fetch
  module_function

  def fetch_links(query)
    url = 'https://newsapi.org/v2/everything?'
    q = query + ' tutorial'
    q.gsub!(' ', '%20')
    page = '1'
    page_size = '100'
    api_key = 'c4b7401b12c240b5a92498f4a6f58bfd'
    res = HTTP.get("#{url}q=#{q}&apiKey=#{api_key}&page=#{page}" \
      "&page_size=#{page_size}")
    res = JSON.parse(res)
    res['articles'].sample unless res['status'] != 'ok'
  end

  def create_articles(topics)
    articles = topics.map do |topic|
      article_json = fetch_links(topic.title)
      article = Article.new(
        title: article_json['title'],
        description: article_json['description'],
        url: article_json['url']
      )
      article if article.save
    end
    articles
  end

  def create_reading_lists(user)
    return if user.topics.empty?
    articles = create_articles(user.topics)
    reading_list = ReadingList.new
    articles.each do |article|
      reading_list.articles << article
    end
    reading_list.save && user.reading_lists << reading_list
    user.save
  end
end
