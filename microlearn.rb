# frozen_string_literal: true

require 'sinatra'
require_relative './app/controllers/main_controller'
require_relative './lib/seeds'

seed

set :bind, '127.0.0.1'
set :port, 5000

class App < Sinatra::Application
end
