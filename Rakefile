# frozen_string_literal: true

task :environment do
  require_relative './microlearn'
  require_relative './app/models/application'
  require_relative './app/helpers/fetch'
  require_relative './app/helpers/mailer'
end

desc 'Create reading_lists and send them daily'
task notifier: :environment do
  users = User.all
  users.each do |user|
    Fetch.create_reading_lists(user)
    Mailer.send_email(user) unless user.unsubscribed?
  end
end
