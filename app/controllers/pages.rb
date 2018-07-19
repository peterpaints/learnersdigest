# frozen_string_literal: true

get '/' do
  redirect '/dashboard' if session[:email]
  erb :index
end

get '/dashboard' do
  require_admin
  @user = User.first(email: session[:email])
  @digests = @user.userdigests.reverse
  @digest = @digests[0]

  erb :dashboard
end

get '/unsubscribe' do
  require_admin
  @user = User.first(email: session[:email])
  @user.unsubscribed = @user.unsubscribed? ? false : true
  @user.save

  if @user.saved?
    flash[:success] = "Great! You've successfully changed subscription status."
    redirect '/'
  end
end
