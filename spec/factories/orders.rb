FactoryBot.define do
  factory :order do
    shopping_cart { nil }
    orderable { nil }
    license { nil }
    complete { false }
    token { "MyString" }
  end
end
