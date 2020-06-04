# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

image_data = JSON.parse(RestClient.get('https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg,png'))
url_list = image_data.map { |image| image["url"] }

breed_data = JSON.parse(RestClient.get('https://api.thecatapi.com/v1/breeds'))

10.times do
    name = Faker::Creature::Cat.name
    User.create(
        username: Faker::Internet.username(specifier: name),
        name: name,
        breed: breed_data.sample["name"],
        password: Faker::Internet.password,
        owner_name: Faker::Name.first_name,
        img_url: url_list.pop
    )
end

5.times do
    breed = breed_data.sample
    Group.create(name: breed["name"], description: breed["description"])
end

User.all.each do |user|
    user.groups << Group.all.sample
end

Post.create(content: "Sleeping under the covers is the best.", user: User.all.sample, post_img: "https://cdn2.thecatapi.com/images/lj.jpg", likes: 0, group: Group.all.sample)
Post.create(content: "Don't you hate it when another cat thinks you need a bath.", user: User.all.sample, post_img: "https://cdn2.thecatapi.com/images/m4.jpg", likes: 0, group: Group.all.sample)
Post.create(content: "This fuzzy thing doesn't taste as good as it looks...", user: User.all.sample, post_img: "https://cdn2.thecatapi.com/images/75j.jpg", likes: 0, group: Group.all.sample)
Post.create(content: "I don't know why it's wet outside. It wasn't yesterday.", user: User.all.sample, post_img: nil, likes: 0, group: Group.all.sample)
Post.create(content: "This seemed like such a good idea at first.", user: User.all.sample, post_img: "https://cdn2.thecatapi.com/images/9r7.jpg", likes: 0, group: Group.all.sample)
Post.create(content: "Nobody else can touch my baby", user: User.all.sample, post_img: "https://cdn2.thecatapi.com/images/ach.jpg", likes: 0, group: Group.all.sample)


puts "Success!"
