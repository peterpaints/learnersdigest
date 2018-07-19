# frozen_string_literal: true

class Userdigest
  include DataMapper::Resource

  property :id,           Serial
  property :created_at,   DateTime
  property :updated_at,   DateTime

  has n, :articles, through: Resource

  belongs_to :user, required: false
end
