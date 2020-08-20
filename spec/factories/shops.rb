FactoryBot.define do
  factory :shop, class: Shop do
    sheets { 20 }
    opening_ours { "10:00\uFF5E22:00" }
    parking { "\u7121" }
    association :member, :other_member

    trait :minato do
      name { "\u6E2F\u533A\u30E9\u30FC\u30E1\u30F3" }
      address { "\u6771\u4EAC\u90FD\u6E2F\u533A\u829D\u516C\u5712\uFF14\u4E01\u76EE\uFF12\u2212\uFF18" }
    end

    trait :other_shop do
      sequence(:name, 1) { |n| "ラーメンショップ#{n}" }
      sequence(:address) { |n| "テスト住所#{n}" }
    end
  end
end
