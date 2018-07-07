require_relative './models'

def seed
  if Topic.count == 0
    Topic.create(title: "JavaScript")
    Topic.create(title: "Python")
    Topic.create(title: "CSS")
    Topic.create(title: "HTML")
    Topic.create(title: "C#")
    Topic.create(title: "Java")
    Topic.create(title: "C++")
    Topic.create(title: "Ruby")
    Topic.create(title: "Ruby on Rails")
  end
end
