# frozen_string_literal: true

module Helpers
  def stub_current_user(current_user)
    get '/', {}, 'rack.session' => { email: current_user.email }
  end
end
