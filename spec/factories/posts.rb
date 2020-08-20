FactoryBot.define do
  factory :post do
    association :shop, :minato
    association :member, :owada

    trait :test0 do
      title { "\u6E2F\u533A\u30E9\u30FC\u30E1\u30F3\u3078\u306E\u6295\u7A3F" }
      comment { "\u30C6\u30B9\u30C8\u30C6\u30B9\u30C8\u30C6\u30B9\u30C8" }
      point { 4.0 }
    end
  end
end
