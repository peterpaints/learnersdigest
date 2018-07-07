require 'sqlite3'
require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'
require 'dm-validations'
require 'bcrypt'
require 'dm-noisy-failures'

configure do
  # Use Heroku or local Sqlite
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/microlearn.db")
end

class Topic

  include DataMapper::Resource

  property :id,           Serial
  property :title,        String

  belongs_to :user, :required => false
  belongs_to :userdigest, :required => false

end

class User

  include DataMapper::Resource

  property :id,           Serial
  property :email,        String, unique: true, required: true, :format => :email_address
  property :password,     Text
  property :created_at,   DateTime
  property :updated_at,   DateTime

  has n, :topics, :constraint => :destroy
  has n, :userdigests, :constraint => :destroy

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
  property :articles,        Text
  property :created_at,   DateTime
  property :updated_at,   DateTime

  has n, :topics, :constraint => :destroy

  belongs_to :user, :required => false

end

configure :development do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
end
