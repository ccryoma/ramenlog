# メインのサンプルユーザーを1人作成する
Member.create!(name:  "りょうま",
             email: "ryoma@ramen.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
70.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@ramen.org"
  password = "password"
  Member.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# 店舗をまとめて生成する
prename = ["麺屋", "製麺所", "ラーメン", "らーめん", "工房"]
50.times do |n|
  name  = prename[rand(5)] + Faker::Name.last_name
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
5.times do |n|
  title  = Faker::Lorem.sentence(word_count: 3)
  comment = Faker::Lorem.sentence(word_count: 20)
  point = n
  shop = Shop.find(1)
  member = Member.find(n + 1)
  member.posts.create!(title: title,
                        comment: comment,
                        point: point,
                        shop: shop,
                        member: member)
end
