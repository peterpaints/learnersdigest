# frozen_string_literal: true

require 'sinatra'
require_relative './app/controllers/application_controller'
require_relative './lib/seeds'

seed

set :bind, '127.0.0.1'
set :port, 5000

class App < ApplicationController
end
