FactoryBot.define do
  factory :book do
    title { Faker::Lorem.word }
    category
    publisher
  end
end
