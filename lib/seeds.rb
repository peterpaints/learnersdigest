# frozen_string_literal: true

require_relative '../app/models/application'

def seed
  return unless Topic.count.zero?
  Topic.create(title: 'JavaScript')
  Topic.create(title: 'Python')
  Topic.create(title: 'CSS')
  Topic.create(title: 'HTML')
  Topic.create(title: 'Golang')
  Topic.create(title: 'Java')
  Topic.create(title: 'C++')
  Topic.create(title: 'Ruby')
  Topic.create(title: 'C')
  Topic.create(title: 'Algorithms')
  Topic.create(title: 'Data Structures')
  Topic.create(title: 'Rust')
end
