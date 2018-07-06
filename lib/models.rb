require 'sqlite3'
require 'pg'
require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require './lib/authorization'

configure do
  # Use Heroku or local Sqlite
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/microlearn.db")
end

class Topic

  include DataMapper::Resource

  property :id,           Serial
  property :title,        String

  has n, :users

end

class User

  include DataMapper::Resource

  property :id,           Serial

  has n, :topics

end

class Digest

  include DataMapper::Resource

  property :id,           Serial

  has n, :topics

end

configure :development do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
end
