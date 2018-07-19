# frozen_string_literal: true

require 'http'

require_relative '../models/models'

module Digest
  module_function

  def fetch_stories(query)
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
    user_articles = topics.map do |topic|
      article_json = fetch_stories(topic.title)
      article = Article.new(
        title: article_json['title'],
        description: article_json['description'],
        url: article_json['url']
      )
      article if article.save
    end
    user_articles
  end

  def create_digests(user)
    return if user.topics.empty?
    articles = create_articles(user.topics)
    digest = Userdigest.new
    articles.each do |article|
      digest.articles << article
    end
    digest.save && user.userdigests << digest
    user.save
  end
end
