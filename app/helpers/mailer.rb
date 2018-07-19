# frozen_string_literal: true

require 'pony'

Pony.options = {
  via: :smtp,
  via_options: {
    address: 'smtp.gmail.com',
    port: '587',
    enable_starttls_auto: true,
    user_name: ENV['EMAIL_USERNAME'],
    password: ENV['EMAIL_PASSWORD'],
    authentication: :plain,
    domain: 'localhost.localdomain'
  }
}

module Mailer
  module_function

  def send_email(user)
    @digest = user.userdigests[-1]
    b = binding
    b.local_variable_set(:digest, @digest)
    template = ERB.new(File.read('app/views/email_digest.erb')).result(b)
    Pony.mail(
      from: 'digests@learnersdigest.com',
      to: user.email,
      subject: 'Here\'s a few links worth your time today',
      html_body: template
    )
  end
end
