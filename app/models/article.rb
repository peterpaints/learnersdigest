# frozen_string_literal: true

class Article
  include DataMapper::Resource

  property :id,           Serial
  property :title,        Text
  property :description,  Text
  property :url,          Text

  belongs_to :reading_list, required: false
end
