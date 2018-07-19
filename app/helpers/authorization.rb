# frozen_string_literal: true

module Sinatra
  module Authorization
    def unauthorized!
      flash[:danger] = "You're not authorized. Please Log In."
      redirect '/'
    end

    def authorized?
      session[:email].nil? ? false : true
    end

    def require_admin
      return if authorized?
      unauthorized!
    end

    def valid_email?(email)
      valid = '[A-Za-z\d.+-]+'
      (email =~ /#{valid}@#{valid}\.#{valid}/) == 0
    end

    def valid_password?(password)
      valid = '(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}'
      (password =~ /#{valid}/) == 0
    end

    def validate_params(params)
      return if valid_email?(params[:email]) && valid_password?(params[:password])
      flash[:danger] = 'Invalid email or password.'
      redirect '/'
    end
  end
end
