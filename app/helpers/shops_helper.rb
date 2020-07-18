module ShopsHelper
  
  #店舗のポイントを取得する
  def shop_point(shop)
    Post.where(shop_id: shop).average("point") || "-"
  end
  
end
