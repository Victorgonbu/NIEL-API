FactoryBot.define do
  factory :order do
    orderable { nil }
    license { nil }
    complete { false }
    user {nil}
    token { "token" }
  end

  factory :order_complete, parent: :order do
    complete {true}
  end
end
