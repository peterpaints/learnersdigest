# frozen_string_literal: true

require 'bcrypt'

FactoryBot.define do
  factory :user do
    email 'test@user.com'
    password BCrypt::Password.create('Testpassword1')
  end
end
