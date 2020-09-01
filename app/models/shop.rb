class Shop < ApplicationRecord
  extend Geocoder::Model::ActiveRecord
  belongs_to :member
  has_many  :posts, dependent: :destroy
  has_many  :shop_tag_relations, dependent: :destroy
  has_many  :tags, through: :shop_tag_relations
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :opening_ours, length: { maximum: 255 }
  validates :parking, length: { maximum: 50 }
  validates :member_id, presence: true
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :address_changed?

  def save_tags(save_tags)
    current_tags = self.tags.nil? ? [] : self.tags.pluck(:id)
    save_tags = [] if save_tags.nil?

    old_tags = current_tags - save_tags
    new_tags = save_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_id|
      self.tags.delete Tag.find(old_id)
    end

    # Create new taggings:
    new_tags.each do |new_id|
      post_tag = Tag.find(new_id)
      self.tags << post_tag
    end
  end

  def self.search(search)
    case search

    # 全件検索
    when "all"
      Shop.eager_load(:posts).select("shops.*, posts.*,round(avg(point),1) as point_avg").group("shops.id").order("point_avg DESC")

    # ホーム画面用
    when "home"
      Shop.eager_load(:posts).select("shops.*, posts.*,round(avg(point),1) as point_avg").group("shops.id").order("posts.created_at DESC").limit(3)

    else
      if search["tag_ids"]
        # タグ指定あり
        if search["AO"] == "AND"
          # AND検索
          Shop.eager_load(:posts).select("shops.*, posts.*,round(avg(point),1) as point_avg")
              .where(id: Shop.joins(:shop_tag_relations).where("address LIKE ? AND name LIKE ? AND tag_id IN (?) ", "%#{search['area']}%", "%#{search['name']}%", search["tag_ids"])
              .group("shops.id").having("count(shops.id) = ?", search["tag_ids"].size)).group("shops.id").order("point_avg DESC")
        else
          # OR検索
          Shop.joins(:shop_tag_relations).where("address LIKE ? AND name LIKE ? AND tag_id IN (?) ", "%#{search['area']}%", "%#{search['name']}%", search["tag_ids"])
              .eager_load(:posts).select("shops.*, posts.*,round(avg(point),1) as point_avg").group("shops.id").order("point_avg DESC")
        end
      else
        # タグ指定なし
        Shop.eager_load(:posts).where("address LIKE ? AND name LIKE ? ", "%#{search['area']}%", "%#{search['name']}%")
            .select("shops.*, posts.*,round(avg(point),1) as point_avg").group("shops.id").order("point_avg DESC")
      end
    end
  end

  # 最新のレビューと画像を取得
  def self.latest_set(shops)
    shop_hash = Hash.new { |h, k| h[k] = {} }
    shops.each do |shop|
      shop_posts = Shop.find(shop.id).posts
      next unless shop_posts

      shop_hash[shop.id][:dtl] = shop_posts.first
      shop_posts.each do |post|
        if post.images.attached?
          shop_hash[shop.id][:img] = post.images[0]
          break
        end
      end
    end
    shop_hash
  end

  # 店舗の平均ポイントを取得
  def self.point_set(shop)
    shop_point = shop.posts.average("point")
    shop_point ? shop_point.round(1) : "未評価"
  end
end
