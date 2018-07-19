# frozen_string_literal: true

require_relative '../models/models'
require_relative '../helpers/authorization'
require_relative '../helpers/digests'
require_relative '../helpers/mailer'

require 'dotenv/load'
require 'sinatra/flash'
require 'gon-sinatra'
require 'json'
require 'pony'
require 'erb'
require 'rufus-scheduler'

set :session_secret, 'SESSION_SECRET'
enable :sessions

helpers do
  include Sinatra::Authorization
  include Digest
  include Mailer
  Sinatra.register Gon::Sinatra
end

configure do
  set :scheduler, Rufus::Scheduler.new
  settings.scheduler.cron '00 07 * * *' do
    @users = User.all
    @users.each do |user|
      Digest.create_digests(user)
      Mailer.send_email(user) unless user.unsubscribed?
    end
  end
end

require_relative 'auth'
require_relative 'pages'
require_relative 'topics'
