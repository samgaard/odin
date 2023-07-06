# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.delete_all
Friendship.delete_all
User.delete_all

User.create(
  name: 'Sam',
  email: 'sam@hcp.com',
  password: 123456
)

10.times do
  User.create(
    name: Faker::Superhero.name,
    email: Faker::Internet.email,
    password: 123456,
  )
end

20.times do
  friend_1 = User.all.sample
  remaining_users = User.all - [friend_1]
  friend_2 = remaining_users.sample
  friendship_exists = friend_1.is_friend(friend_2.id)
  unless friendship_exists
    Friendship.create(
      sender_id: friend_1.id,
      receiver_id: friend_2.id,
      approved: [true, false].sample
    )
  end
end

10.times do
  Post.create(
    author: User.all.sample,
    body: Faker::Lorem.paragraph
  )
end

10.times do
  Like.create(
    post: Post.all.sample,
    friend: User.all.sample
  )
end