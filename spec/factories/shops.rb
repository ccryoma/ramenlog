FactoryBot.define do
  factory :shop, class: Shop do
    sheets { 20 }
    opening_ours { '10:00～22:00' }
    parking { '無' }
    association :member, :other_member

    trait :minato do
      name { '港区ラーメン' }
      address { '東京都港区芝公園４丁目２−８' }
    end

    trait :other_shop do
      sequence(:name,1){|n| "ラーメンショップ#{n}"}
      sequence(:address){|n| "テスト住所#{n}"}
    end
  end
end
  