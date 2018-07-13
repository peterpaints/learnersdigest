class Article

  include DataMapper::Resource

  property :id,           Serial
  property :title,        Text
  property :description,  Text
  property :url,          Text

  belongs_to :userdigest, :required => false

end
