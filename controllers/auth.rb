# frozen_string_literal: true

post '/register' do
  validate_params(params)
  @user = User.first(email: params[:email])
  if @user
    flash[:danger] = 'User already exists. Please Log In.'
    redirect '/'
  else
    @user = User.new email: params[:email]
    @user.password = @user.hash_password params[:password]
    @user.save

    if @user.saved?
      session[:email] = @user.email
      redirect '/topics'
    else
      flash[:danger] = 'Could not create user. Please try again.'
      redirect '/'
    end
  end
end

post '/login' do
  validate_params(params)
  @user = User.first(email: params[:email])
  if @user.nil?
    flash[:danger] = 'You do not have an account. Please register.'
    redirect '/'
  end

  if @user.registered_password? params[:password]
    session[:email] = @user.email
    redirect '/dashboard'
  else
    flash[:danger] = 'Wrong username or password. Please try again.'
    redirect '/'
  end
end

get '/logout' do
  require_admin
  session[:email] = nil
  redirect '/'
end

get '/signout' do
  require_admin
  @user = User.first(email: session[:email])
  @user.destroy
  session[:email] = nil
  redirect '/'
end
