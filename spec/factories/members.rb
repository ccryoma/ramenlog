FactoryBot.define do
  factory :member, class: Member do
    password { "password" }
    password_digest { Member.digest("password") }
    admin { false }
    activated { true }
    activated_at { Time.zone.now }

    trait :admin do
      name { "管理ユーザー" }
      email { "admin@example.com" }
      admin { true }
    end

    trait :hanzawa do
      name { "半沢直樹" }
      email { "naoki@example.com" }
    end

    trait :owada do
      name { "大和田暁" }
      email { "owada@example.com" }
    end

    trait :isayama do
      name { "伊佐山泰二" }
      email { "isayama@example.com" }
    end

    trait :other_member do
      name { Faker::Name.name }
      email { Faker::Internet.email }
    end
  end
end
