require 'rufus-scheduler'
require 'http'

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

  def self.email
  end
end
