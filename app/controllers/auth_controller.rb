# frozen_string_literal: true

class AuthController < ApplicationController
  post '/register' do
    user = User.new(email: params[:email], password: params[:password])

    if user.save
      session[:email] = user.email
      redirect '/topics'
    else
      redirect_with_error(user.errors.first.join)
    end
  end

  post '/login' do
    user = User.first(email: params[:email])
    if user.nil?
      redirect_with_error('You do not have an account. Please register.')
    end

    if user.authenticate? params[:password]
      session[:email] = user.email
      redirect '/dashboard'
    else
      redirect_with_error('Wrong email or password. Please try again.')
    end
  end

  get '/logout' do
    session[:email] = nil
    redirect '/'
  end

  get '/user/delete/:id' do
    @user.destroy
    session[:email] = nil
    redirect '/'
  end
end
