# frozen_string_literal: true

require 'dotenv/load'
require 'sinatra/flash'
require 'gon-sinatra'
require 'json'
require 'pony'
require 'erb'
require 'rufus-scheduler'
require 'require_all'

require_relative '../models/application'

require_all './app/helpers/'
require_all './app/controllers'

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

before do
  unless ['register', 'login', nil].include? request.path_info.split('/')[1]
    require_login
    @user = User.first(email: session[:email])
  end
end
