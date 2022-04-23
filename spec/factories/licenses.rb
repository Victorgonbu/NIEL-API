FactoryBot.define do
  factory :license do
    name { Faker::Lorem.sentence }
    privileges { [Faker::Lorem.word, Faker::Lorem.word] }
    files { [Faker::Lorem.word, Faker::Lorem.word] }
    price_cents { 30 }
  end

  factory :standard, parent: :license do 
    uuid { 1 }
  end

  factory :premium, parent: :license do
    price_cents { 50 }
    uuid { 2 }
  end

  factory :unlimited, parent: :license do
    price_cents { 100 }
    uuid { 3 }
  end
end
