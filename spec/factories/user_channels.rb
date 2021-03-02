FactoryBot.define do
  factory :user_channel do
    user
    channel
    joined_at { DateTime.now }
  end
end
