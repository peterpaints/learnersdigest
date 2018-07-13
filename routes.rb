require_relative './lib/authorization'
require_relative './lib/models'
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
			:authentication => :plain, # :plain, :login, :cram_md5, no auth by default
    	:domain => "localhost:5000" # the HELO domain provided by the client to the server
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

get '/' do
	if session[:email]
		redirect '/dashboard'
	end
	erb :index
end

get '/topics' do
	require_admin
	@topics = Topic.all
	@topic_titles = []
	@topics.each { |topic| @topic_titles << topic.title }
	gon.topic_titles = @topic_titles
	@user = User.first(:email => session[:email])
	@digests = @user.userdigests
	erb :topics
end

post '/topics' do
	require_admin
	content_type :json
	@user = User.first(:email => session[:email])
	if params[:selected_topics]
		params[:selected_topics].each do |selected_topic|
			topic = Topic.first(:title => selected_topic)
			@user.topics << topic
		end

		@user.save
		if @user.saved?
			status 201
			{
				success: true,
				status: 201,
			}.to_json
		else
			status 500
			{
				error: true,
				status: 500,
				message: 'Could not save topics. Please try again.'
			}.to_json
		end
	else
		if @user.topics.empty?
			status 500
			{
				error: true,
				status: 500,
				message: 'Surely, you want to learn something?'
			}.to_json
		end
	end
end

get '/dashboard' do
	require_admin
	@user = User.first(:email => session[:email])
	@digests = @user.userdigests.reverse
	@digest = @digests[0]

	erb :dashboard
end

post '/register' do
	validate_params(params)
	@user = User.first(:email => params[:email])
	if @user
		flash[:danger] = "User already exists. Please Log In."
		redirect '/'
	else
		@user = User.new email: params[:email]
		@user.password = @user.hash_password params[:password]
		@user.save

		if @user.saved?
			session[:email] = @user.email
			redirect '/topics'
		else
			flash[:danger] = "Could not create user. Please try again."
			redirect '/'
		end
	end
end

post '/login' do
	validate_params(params)
	@user = User.first(:email => params[:email])
	if not @user
		flash[:danger] = "You do not have an account. Please register."
		redirect '/'
	end

	if @user.is_registered_password params[:password]
		session[:email] = @user.email
		redirect '/dashboard'
	else
		flash[:danger] = "Wrong username or password. Please try again."
		redirect '/'
	end
end

get "/logout" do
	session[:email] = nil
	redirect "/"
end
