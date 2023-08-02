# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Comment.delete_all
Like.delete_all
Post.delete_all
Friendship.delete_all
User.delete_all

User.create(
  name: 'Sam',
  email: 'sam@hcp.com',
  password: 123_456
)

10.times do
  User.create(
    name: Faker::Superhero.name,
    email: Faker::Internet.email,
    password: 123_456
  )
end

50.times do
  friend1 = User.all.sample
  remaining_users = User.all - [friend1]
  friend2 = remaining_users.sample
  friendship_exists = friend1.is_friend(friend2.id)
  next if friendship_exists

  Friendship.create(
    sender_id: friend1.id,
    receiver_id: friend2.id,
    approved: [true, false].sample
  )
end

30.times do
  Post.create(
    author: User.all.sample,
    body: Faker::ChuckNorris.fact,
    created_at: Date.today - rand(10)
  )
end

20.times do
  Like.create(
    post: Post.all.sample,
    friend: User.all.sample
  )
end

20.times do
  Comment.create(
    post: Post.all.sample,
    body: Faker::ChuckNorris.fact,
    user: User.all.sample
  )
end
