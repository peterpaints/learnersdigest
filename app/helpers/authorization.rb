# frozen_string_literal: true

module Authorization
  def unauthorized
    flash[:danger] = "You're not authorized. Please Log In."
    redirect '/'
  end

  def logged_in?
    session[:email]
  end

  def require_login
    return if logged_in?
    unauthorized
  end
end
