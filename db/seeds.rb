# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: "Website")
Category.create(name: "Mobile")
Category.create(name: "Embedded")
Category.create(name: "Game")
Category.create(name: "Multi Platform")
Category.create(name: "Category 1", target_type: 0)

Category.create(name: "Category 2", target_type: 0)
5.times.each do |i|
  name =  "Project #{i+1}"
  url = "http://randomtextgenerator.com/"
  description = "Since you may want to make addresses and other types of data
  look different depending on where in the world you are (US postal codes vs.
  UK postal codes, for example)"
  core_features = "Faker uses the I18n gem to store strings (like state names) "
  realease_note = "v1.0"
  git_repository = "https://github.com/kyhuuhai/CDIO4"
  server_information = "Not deploy yet"
  platform = "Website"
  category_id = "#{i+1}"
  is_suggest = "false"

  p = Project.create(name: name,
                  description: description,
                  url: url,
                  core_features: core_features,
                  realease_note: realease_note,
                  server_information: server_information,
                  platform: platform,
                  category_id: category_id,
                  is_suggest: is_suggest)
end

u = User.create(name: "Bin", email:"admin@gmail.com",
  password: "password123",
  is_admin: "true")

4.times do |i|
  name  = "User #{i+1}"
  email = "user#{i+1}@gmail.com"
  password = "password123"
  is_admin = "false"
  u = User.create!(name:  name,
               email: email,
               password: password,
               is_admin: is_admin)
end

User.all.each do |user|
  user.images.create
end

Project.all.each do |project|
  project.images.create
end
