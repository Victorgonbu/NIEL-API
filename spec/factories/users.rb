FactoryBot.define do
  factory :user do
    name { "test user" }
    email { "noadminuser@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :admin, parent: :user do
    email {"adminuser@gmail.com"}
    admin {true}
  end

  factory :invalid_user, parent: :user do
    name { "i" }
    email { "invalidemail" }
  end
end
