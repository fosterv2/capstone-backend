# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

image_data = JSON.parse(RestClient.get('https://api.thecatapi.com/v1/images/search?limit=20'))
url_list = image_data.map { |image| image["url"] }
img_list = url_list.filter { |url| url.split(".").last != "gif" }

10.times do
    name = Faker::Creature::Cat.name
    User.create(username: Faker::Internet.username(specifier: name), name: name, breed: Faker::Creature::Cat.breed,
                password: Faker::Internet.password, owner_name: Faker::Name.first_name, img_url: img_list.pop)
end


puts "Success!"
