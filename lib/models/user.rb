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
