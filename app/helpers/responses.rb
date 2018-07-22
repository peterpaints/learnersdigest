# frozen_string_literal: true

module Responses
  def res(status_code, message)
    status(status_code)
    {
      success: true,
      status: status_code,
      message: message
    }.to_json
  end

  def redirect_with_error(message)
    flash[:danger] = message
    redirect '/'
  end
end
