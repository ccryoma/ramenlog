FactoryBot.define do
  factory :shop do
    sheets { 20 }
    opening_ours { '10:00～22:00' }
    parking { '無' }
    association :member, :admin

    trait :minato do
      name { '港区ラーメン' }
      address { '東京都港区芝公園４丁目２−８' }
    end
  end
end
  