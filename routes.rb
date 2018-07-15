require_relative './lib/authorization'
require_relative './lib/models/models'
require_relative './lib/digests'

require 'dotenv/load'
require 'sinatra/flash'
require 'gon-sinatra'
require 'json'
require 'pony'

set :session_secret, 'SESSION_SECRET'
enable :sessions

helpers do
	include Sinatra::Authorization
	include Digest
	Sinatra::register Gon::Sinatra
end

configure do
	Pony.options = {
		:via => :smtp,
		:via_options => {
			:address => 'smtp.gmail.com',
			:port => '587',
			:enable_starttls_auto => true,
			:user_name => ENV['GMAIL_USERNAME'],
			:password => ENV['GMAIL_PASSWORD'],
			:authentication => :plain,
    	:domain => "localhost.localdomain"
		}
	}

	set :scheduler, Digest.scheduler

	settings.scheduler.every('1d') do
		@users = User.all
		@users.each do |user|
			Digest.create_digests user
			# Digest.email user
		end
	end
end

require_relative './controllers/auth'
require_relative './controllers/routes'
require_relative './controllers/topics'
