require_relative './lib/authorization'
require_relative './lib/models'

require 'sinatra/flash'

enable :sessions

helpers do
	include Sinatra::Authorization
end

get '/' do
	if session[:email]
		redirect '/dashboard'
	end
	erb :index
end

get '/topics' do
	require_admin
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
  session[:username] = nil
  redirect "/"
end
