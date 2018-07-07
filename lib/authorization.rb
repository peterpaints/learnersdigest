module Sinatra
  module Authorization

  def unauthorized!
    throw :halt, [ 401, 'Authorization Required' ]
  end

  def bad_request!
    throw :halt, [ 400, 'Bad Request' ]
  end

  def authorized?
    session[:email].nil? ? false : true
  end

  def require_admin
    return if authorized?
    unauthorized!
  end

  def admin?
    authorized?
  end

  end
end
