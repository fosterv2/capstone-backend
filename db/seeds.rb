# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

image_data = JSON.parse(RestClient.get('https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg,png'))
url_list = image_data.map { |image| image["url"] }

breed_data = JSON.parse(RestClient.get('https://api.thecatapi.com/v1/breeds?limit=5'))

5.times do
    name = Faker::Creature::Cat.name
    User.create(
        username: Faker::Internet.username(specifier: name),
        breed: breed_data.sample["name"],
        password: Faker::Internet.password,
        owner_name: Faker::Name.first_name,
        img_url: url_list.pop
    )
end

5.times do
    breed = breed_data.pop
    Group.create(name: breed["name"], description: breed["description"])
end

User.all.each do |user|
    user.groups << Group.all.sample
end

Post.create(content: "Sleeping under the covers is the best.", 
    user_id: 2, post_img: "https://cdn2.thecatapi.com/images/lj.jpg", likes: 0, group: Group.all.sample)
Post.create(content: "Don't you hate it when another cat thinks you need a bath?", 
    user_id: 1, post_img: "https://cdn2.thecatapi.com/images/m4.jpg", likes: 0, group: Group.all.sample)
Post.create(content: "This fuzzy thing doesn't taste as good as it looks...", 
    user_id: 3, post_img: "https://cdn2.thecatapi.com/images/75j.jpg", likes: 0, group: Group.all.sample)
Post.create(content: "I don't know why it's wet outside. It wasn't yesterday.", 
    user_id: 1, post_img: "", likes: 0, group: Group.all.sample)
Post.create(content: "This looked so easy to climb at first.", 
    user_id: 4, post_img: "https://cdn2.thecatapi.com/images/9r7.jpg", likes: 0, group: Group.all.sample)
Post.create(content: "Nobody else can touch my baby", 
    user_id: 5, post_img: "https://cdn2.thecatapi.com/images/ach.jpg", likes: 0, group: Group.all.sample)

Comment.create(content: "Especially when there's another cat with you", post_id: 1, user: User.all.sample)
Comment.create(content: "I'm always looking for covers to burrow into", post_id: 1, user: User.all.sample)
Comment.create(content: "I was just trying to help", post_id: 2, user: User.all.sample)
Comment.create(content: "They never do", post_id: 3, user: User.all.sample)
Comment.create(content: "All the fun is in trying to catch it", post_id: 3, user: User.all.sample)
Comment.create(content: "It should be sunny all the time", post_id: 4, user: User.all.sample)
Comment.create(content: "I hate wet", post_id: 4, user: User.all.sample)
Comment.create(content: "Never stop trying to climb", post_id: 5, user: User.all.sample)
Comment.create(content: "Try again. It'll definitely work next time", post_id: 5, user: User.all.sample)
Comment.create(content: "All kittens must be protected", post_id: 6, user: User.all.sample)
Comment.create(content: "You're a good cat mom", post_id: 6, user: User.all.sample)


# kitten pile / tigger : https://cdn2.thecatapi.com/images/26c.jpg
# turnip-ish : https://cdn2.thecatapi.com/images/e1o.jpg


puts "Success!"
