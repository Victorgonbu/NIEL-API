FactoryBot.define do
  factory :track do
    name { "MyString" }
    bpm { 1 }
    pcm { "MyText" }
    buyable { false }
  end
end
