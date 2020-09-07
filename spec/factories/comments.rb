FactoryBot.define do
  factory :comment do
    content {Faker::Lorem.sentence}
    user {FactoryBot.create :user}
  end
end
