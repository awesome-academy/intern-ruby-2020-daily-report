FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.unique.email}
    password {Settings.rspec.default_password}
    password_confirmation {Settings.rspec.default_password}
    division {FactoryBot.create :division}
  end
end
