# create 10 public channels
10.times do
  Channel.create(
    name: Faker::Company.industry
  )
end

# create 5 private channels
5.times do
  Channel.create(
    name: Faker::Company.industry ,
    is_public: false
  )
end

# create 5 users
5.times do
  password = '123123'
  User.create(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password 
  )
end

# create user_channels (4 users joined first 5 channels)
users = User.limit(4)

users.each do |user|
  UserChannel.create(user_id: user.id, channel_id: 1, joined_at: DateTime.now)
  UserChannel.create(user_id: user.id, channel_id: 2, joined_at: DateTime.now)
  UserChannel.create(user_id: user.id, channel_id: 3, joined_at: DateTime.now)
  UserChannel.create(user_id: user.id, channel_id: 4, joined_at: DateTime.now)
  UserChannel.create(user_id: user.id, channel_id: 5, joined_at: DateTime.now)
end

# create messages to the first 5 channels
users.each do |user|
  Message.create(user_id: user.id, channel_id: 1, content: Faker::Lorem.sentence)
  Message.create(user_id: user.id, channel_id: 2, content: Faker::Lorem.sentence)
  Message.create(user_id: user.id, channel_id: 3, content: Faker::Lorem.sentence)
  Message.create(user_id: user.id, channel_id: 4, content: Faker::Lorem.sentence)
  Message.create(user_id: user.id, channel_id: 5, content: Faker::Lorem.sentence)
end
