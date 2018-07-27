# frozen_string_literal: true

class User
  include DataMapper::Resource

  VALID_PASSWORD = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/

  property :id,           Serial
  property :email,        String, unique: true, required: true,
                                  format: :email_address,
                                  messages: {
                                    presence: 'Invalid email or password.',
                                    is_unique: 'User already exists.' \
                                    ' Please Log In.',
                                    format: 'Invalid email or password.'
                                  }
  property :password,     Text, required: true,
                                format: VALID_PASSWORD,
                                messages: {
                                  presence: 'Invalid email or password.',
                                  format: 'Invalid email or password.'
                                }
  property :unsubscribed, Boolean, default: false
  property :created_at,   DateTime
  property :updated_at,   DateTime

  has n, :topics, through: Resource
  has n, :reading_lists, through: Resource

  before :create, :hash_password

  def hash_password
    password_hash = BCrypt::Password.create(password)
    self.password = password_hash
  end

  def authenticate?(password)
    BCrypt::Password.new(self.password) == password
  end
end
