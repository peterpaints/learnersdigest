# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'factory_bot'
require 'database_cleaner'
require 'dm-rspec'
require 'webmock/rspec'
require 'simplecov'
require 'coveralls'

SimpleCov.start
Coveralls.wear!

ENV['RACK_ENV'] = 'test'

require_relative '../microlearn.rb'
require_relative './support/fake_newsapi'

WebMock.disable_net_connect!(allow_localhost: true)

module RSpecMixin
  include Rack::Test::Methods
  include FactoryBot::Syntax::Methods
  def app
    Sinatra::Application
  end
end

# For RSpec 2.x and 3.x
RSpec.configure do |c|
  c.include RSpecMixin
  c.include(DataMapper::Matchers)

  c.before(:suite) do
    FactoryBot.find_definitions
  end

  c.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    stub_request(:any, /newsapi.org/).to_rack(FakeNewsAPI)
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
end
