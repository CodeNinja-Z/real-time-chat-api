FactoryBot.define do
  factory :channel do
    name { Faker::Name.unique.name }
    is_public { true }

    after(:create) do |channel|
      user = create(:user)
      channel.user_channels << build(:user_channel, channel: channel, user: user)
      create_list(:message, 3, channel: channel, user: user)
    end
  end
end
