crumb :root do
  link "麺びより", root_path
end

crumb :login do
  link "ログイン", login_path
  parent :root
end

crumb :password_resets do
  link "パスワード再設定", login_path
  parent :root
end

crumb :members do
  link "会員一覧", members_path
  parent :root
end

crumb :signup do
  link "会員登録", signup_path
  parent :root
end

crumb :edit_member do |member|
  link "会員情報の更新", edit_member_path(member)
  parent :root
end

crumb :postlist_member do |member|
  link member.name + "さんのプロフィール", postlist_member_path(member)
  parent :root
end

crumb :search do
  link "店舗検索(一覧)", search_path
  parent :root
end

crumb :map do
  link "店舗検索(地図)", map_path
  parent :root
end

crumb :registration do
  link "店舗登録", registration_path
  parent :root
end

crumb :shops_show do |shop|
  link shop.name, shop
  parent :root
end

crumb :edit_shop do |shop|
  link "店舗情報の更新", edit_shop_path(shop)
  parent :shops_show,shop
end

crumb :postlist do |shop|
  link "レビュー一覧", postlist_path(shop)
  parent :shops_show,shop
end
