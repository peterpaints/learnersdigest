# frozen_string_literal: true

require 'sinatra'

class FakeNewsAPI < Sinatra::Base
  get '/v2/everything' do
    json_response(200, 'articles.json')
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status(response_code)
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
