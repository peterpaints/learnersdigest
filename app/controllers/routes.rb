# frozen_string_literal: true

require 'dotenv/load'
require 'sinatra/flash'
require 'gon-sinatra'
require 'json'
require 'pony'
require 'erb'
require 'rufus-scheduler'
require 'require_all'

require_relative '../models/models'
require_relative 'auth'
require_relative 'pages'
require_relative 'topics'

require_all './app/helpers/'

set :session_secret, 'SESSION_SECRET'
set :views, "#{settings.root}/app/views/"
enable :sessions

helpers do
  include Authorization
  include Fetch
  include Mailer
  include Responses
  Sinatra.register Gon::Sinatra
end

before do
  unless ['register', 'login', nil].include? request.path_info.split('/')[1]
    require_admin
    @user = User.first(email: session[:email])
  end
end

configure :development do
  set :scheduler, Rufus::Scheduler.new
  settings.scheduler.cron '00 07 * * *' do
    @users = User.all
    @users.each do |user|
      Fetch.create_reading_lists(user)
      Mailer.send_email(user) unless user.unsubscribed?
    end
  end
end
