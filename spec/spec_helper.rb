require 'rack/test'
require 'rspec'
require 'factory_bot'
require 'database_cleaner'
require 'simplecov'

SimpleCov.start

ENV['RACK_ENV'] = 'test'

require_relative '../microlearn.rb'

module RSpecMixin
  include Rack::Test::Methods
  include FactoryBot::Syntax::Methods
  def app
    Sinatra::Application
  end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c|
  c.include RSpecMixin

  c.before(:suite) do
    FactoryBot.find_definitions
  end

  c.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
}
