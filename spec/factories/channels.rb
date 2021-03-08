FactoryBot.define do
  factory :channel do
    name { Faker::Name.unique.name }
    is_public { true }
  end
end
