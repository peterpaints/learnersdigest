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

class Topic

  include DataMapper::Resource

  property :id,           Serial
  property :title,        String

  has n, :users, :through => Resource
end

class User

  include DataMapper::Resource

  property :id,           Serial
  property :email,        String, unique: true, required: true, :format => :email_address
  property :password,     Text, required: true
  property :created_at,   DateTime
  property :updated_at,   DateTime

  has n, :topics, :through => Resource
  has n, :userdigests, :through => Resource

  def hash_password(password)
    password_hash = BCrypt::Password.create(password)
    password_hash
  end

  def is_registered_password(password)
    BCrypt::Password.new(self.password) == password
  end

end

class Userdigest

  include DataMapper::Resource

  property :id,           Serial
  property :created_at,   DateTime
  property :updated_at,   DateTime

  has n, :articles, :through => Resource

  belongs_to :user, :required => false

end

class Article

  include DataMapper::Resource

  property :id,           Serial
  property :title,        Text
  property :description,  Text
  property :url,          Text

  belongs_to :userdigest, :required => false

end

configure :development do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
end

configure :test do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
end
