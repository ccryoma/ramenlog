# メインのサンプルユーザーを1人作成する
Member.create!(name: "りょうま",
               email: "ryoma@ramen.org",
               password: "foobar",
               password_confirmation: "foobar",
               admin: true,
               activated: true,
               activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@ramen.org"
  password = "password"
  Member.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
end

# 店舗をまとめて生成する
prename = %W[\u9EBA\u5C4B \u88FD\u9EBA\u6240 \u30E9\u30FC\u30E1\u30F3 \u3089\u30FC\u3081\u3093 \u5DE5\u623F]
40.times do |n|
  name = prename[rand(5)] + Faker::Name.last_name
  address = Faker::Address.state
  opening_ours = "10:00～#{20 + n % 6}:00"
  sheets = n
  parking = "無し"
  member = Member.find(n + 1)
  member.shops.create!(name: name,
                       address: address,
                       opening_ours: opening_ours,
                       sheets: sheets,
                       parking: parking,
                       member: member)
end

# 投稿をまとめて生成する
30.times do |n|
  title = Faker::Lorem.sentence(word_count: 3)
  comment = Faker::Lorem.sentence(word_count: 20)
  point = rand(6)
  shop = Shop.find(1 + n % 10)
  member = Member.find(n + 1)
  member.posts.create!(title: title,
                       comment: comment,
                       point: point,
                       shop: shop,
                       member: member)
end

# タグを生成する
Tag.create!([
              { name: "\u30E9\u30FC\u30E1\u30F3" },
              { name: "\u3064\u3051\u9EBA" },
              { name: "\u6CB9\u305D\u3070" },
              { name: "\u30BF\u30F3\u30E1\u30F3" },
              { name: "\u592A\u9EBA" },
              { name: "\u7D30\u9EBA" },
              { name: "\u5E73\u6253\u3061\u9EBA" },
              { name: "\u5200\u524A\u9EBA" },
              { name: "\u3057\u3087\u3046\u3086" },
              { name: "\u3057\u304A" },
              { name: "\u307F\u305D" },
              { name: "\u3068\u3093\u3053\u3064" },
              { name: "\u80CC\u8102" },
              { name: "\u9B5A\u4ECB" },
              { name: "\u716E\u5E72\u3057" },
              { name: "\u9D8F\u767D\u6E6F" },
              { name: "\u6FC0\u8F9B" },
              { name: "\u4E8C\u90CE\u7CFB" },
              { name: "\u5BB6\u7CFB" },
              { name: "\u535A\u591A\u7CFB" }
            ])

# タグをまとめて紐付けする
20.times do |n|
  shop = Shop.find(1 + n % 5)
  shop.shop_tag_relations.create!(
    shop: shop,
    tag_id: n + 1
  )
end
