FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123123' }
    password_confirmation { '123123' }
  end
end
