# frozen_string_literal: true

task :environment do
  require_relative './microlearn'
  require_relative './app/models/models'
  require_relative './app/helpers/digests'
  require_relative './app/helpers/mailer'
end

desc 'Create digests and send them daily'
task notifier: :environment do
  @users = User.all
  @users.each do |user|
    Digest.create_digests(user)
    Mailer.send_email(user) unless user.unsubscribed?
  end
end
