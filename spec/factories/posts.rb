FactoryBot.define do
  factory :post do
    association :shop, :minato
    association :member, :owada

    trait :test0 do
      title { '港区ラーメンへの投稿' }
      comment { 'テストテストテスト' }
      point { 4.0 }
    end
  end
end