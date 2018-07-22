# frozen_string_literal: true

require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require 'dm-validations'
require 'dm-postgres-adapter'
require 'bcrypt'
require 'dotenv/load'
# require 'dm-noisy-failures'

configure :development, :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

configure :test do
  DataMapper.setup(:default, ENV['DATABASE_TEST'])
end

require_relative './topic'
require_relative './user'
require_relative './reading_list'
require_relative './article'

configure :development, :test, :production do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
end
