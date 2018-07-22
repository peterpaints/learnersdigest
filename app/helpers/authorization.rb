# frozen_string_literal: true

module Authorization
  def unauthorized
    flash[:danger] = "You're not authorized. Please Log In."
    redirect '/'
  end

  def authorized?
    session[:email]
  end

  def require_admin
    return if authorized?
    unauthorized
  end
end
