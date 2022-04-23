FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :admin, parent: :user do
    email { Faker::Internet.email }
    admin { true }
  end

  factory :invalid_user, parent: :user do
    name { Faker::Lorem.characters(number: 1) }
    email { Faker::Lorem.sentence }
  end
end
