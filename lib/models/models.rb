require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require 'dm-validations'
require 'dm-postgres-adapter'
require 'bcrypt'
require 'dotenv/load'
# require 'dm-noisy-failures'

configure :development do
  DataMapper.setup(:default, ENV['DATABASE_DEV'])
end

configure :test do
  DataMapper.setup(:default, ENV['DATABASE_TEST'])
end

require_relative './topic'
require_relative './user'
require_relative './digest'
require_relative './article'

configure :development do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
end

configure :test do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
end
