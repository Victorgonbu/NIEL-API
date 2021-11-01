FactoryBot.define do
  factory :license do
    name { "License name" }
    description { "License description" }
    files {"mp3"}
    price_cents { 30 }
  end

  factory :standard, parent: :license do 
    number {1}
  end

  factory :premium, parent: :license do
    price_cents { 50 }
    number {2}
  end

  factory :unlimited, parent: :license do
    price_cents { 100 }
    number {3}
  end
end
