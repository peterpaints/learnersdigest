require_relative './lib/authorization'
require_relative './lib/models'

require 'sinatra/flash'
require 'gon-sinatra'

set :session_secret, 'SESSION_SECRET'
enable :sessions

helpers do
	include Sinatra::Authorization
	Sinatra::register Gon::Sinatra
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
	# gon.selected_topics = []
	# if gon.selected_topics
	# 	@ids = gon.selected_topics.map do |selected_topic|
	# 		topic = Topic.get(:title => selected_topic)
	# 		topic.id
	# 	end
	# 	@user = User.first(:email => session[:email])
	# 	@user.topics = @ids unless @user.nil?
	# end
	erb :topics
end

get '/dashboard' do
	require_admin
	erb :dashboard
end

post '/register' do
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
	@user = User.first(:email => params[:email])
	if not @user
		flash[:danger] = "Wrong username or password. Please try again."
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
