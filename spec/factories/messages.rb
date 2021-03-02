FactoryBot.define do
  factory :message do
    user
    channel
    content { Faker::Lorem.sentence }
  end
end
