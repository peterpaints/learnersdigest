require 'rufus-scheduler'
require 'http'
require 'pony'

require_relative './models'

module Digest
  def self.fetch_article(query)
    url = 'https://newsapi.org/v2/everything?'
    q = query + ' tutorial'
    q.gsub! ' ', '%20'
    page = '1'
    page_size = '100'
    api_key = 'c4b7401b12c240b5a92498f4a6f58bfd'
    res = HTTP.get(url + 'q=' + q + '&apiKey=' + api_key + '&page=' + page + '&page_size=' + page_size)
    res = JSON.parse(res)
    res['articles'].sample unless res['status'] != "ok"
  end

  def self.scheduler
    @scheduler ||= Rufus::Scheduler.new
  end

  def self.create_digests(user)
    unless user.topics.empty?
      user_stories = user.topics.map do |topic|
        article_json = self.fetch_article topic.title
        article = Article.new title: article_json['title'], description: article_json['description'], url: article_json['url']
        article if article.save
      end
    end

    digest = Userdigest.new

    unless user_stories.empty?
      user_stories.each do |article|
        digest.articles << article
      end
      digest.save
      user.userdigests << digest
      user.save
    end
  end

  def self.email(user)
    Pony.mail(
  		to: user.email,
  		subject: 'Here\'s a few links worth your time',
  		html_body: erb(
  			:digest,
  			layout: false,
  		),
  	)
  end
end
