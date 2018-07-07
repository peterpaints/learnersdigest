require 'sinatra'
require_relative 'routes'
require_relative './lib/seeds'

seed

set :bind, '127.0.0.1'
set :port, 5000
