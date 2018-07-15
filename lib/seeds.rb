require_relative './models/models'

def seed
  if Topic.count == 0
    Topic.create(title: "JavaScript")
    Topic.create(title: "Python")
    Topic.create(title: "CSS")
    Topic.create(title: "HTML")
    Topic.create(title: "Golang")
    Topic.create(title: "Java")
    Topic.create(title: "C++")
    Topic.create(title: "Ruby")
    Topic.create(title: "C")
    Topic.create(title: "Algorithms")
    Topic.create(title: "Data Structures")
    Topic.create(title: "Rust")
  end
end
