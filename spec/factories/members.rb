FactoryBot.define do
  factory :member, class: Member do
    password { "password" }
    password_digest { Member.digest("password") }
    admin { false }
    activated { true }
    activated_at { Time.zone.now }

    trait :admin do
      name { "\u7BA1\u7406\u30E6\u30FC\u30B6\u30FC" }
      email { "admin@example.com" }
      admin { true }
    end

    trait :hanzawa do
      name { "\u534A\u6CA2\u76F4\u6A39" }
      email { "naoki@example.com" }
    end

    trait :owada do
      name { "\u5927\u548C\u7530\u6681" }
      email { "owada@example.com" }
    end

    trait :isayama do
      name { "\u4F0A\u4F50\u5C71\u6CF0\u4E8C" }
      email { "isayama@example.com" }
    end

    trait :other_member do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end
  end
end
