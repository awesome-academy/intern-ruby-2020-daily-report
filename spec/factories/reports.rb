FactoryBot.define do
  factory :report do
    today_plan {Faker::Lorem.sentence}
    actual {Faker::Lorem.sentence}
    reason_not_complete {Faker::Lorem.sentence}
    tomorrow_plan {Faker::Lorem.sentence}
    free_comment {Faker::Lorem.sentence}
    user {FactoryBot.create :user}
  end
end
