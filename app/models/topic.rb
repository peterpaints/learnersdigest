# frozen_string_literal: true

class Topic
  include DataMapper::Resource

  property :id,           Serial
  property :title,        String

  has n, :users, through: Resource
end
