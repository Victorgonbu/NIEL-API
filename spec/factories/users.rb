FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_hash { "MyString" }
    country { "MyString" }
    admin { "" }
  end
end
