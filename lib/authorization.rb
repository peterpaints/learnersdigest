module Sinatra
  module Authorization

  def unauthorized!
    # throw :halt, [ 401, 'Authorization Required' ]
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

  def is_valid_email?(email)
    valid = '[A-Za-z\d.+-]+'
    (email =~ /#{valid}@#{valid}\.#{valid}/) == 0
  end

  def is_valid_password?(password)
    valid = '(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}'
    (password =~ /#{valid}/) == 0
  end

  def validate_params(params)
    return if self.is_valid_email?(params[:email]) && self.is_valid_password?(params[:password])
    flash[:danger] = 'Invalid email or password.'
    redirect '/'
  end

  end
end
