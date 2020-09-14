class Shop < ApplicationRecord
  extend Geocoder::Model::ActiveRecord
  belongs_to :member
  belongs_to :latest_post, class_name: "Post", optional: true
  belongs_to :latest_img, class_name: "Post", optional: true
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
      Shop.order("point_avg DESC")

    # ホーム画面用
    when "home"
      Shop.joins(:posts).order("posts.created_at DESC").limit(3)
    else
      # 店舗詳細ページからのリンク
      if search["shop"]
        Shop.where("id = #{search['shop']}")
      elsif search["tag_ids"]
        # タグ指定あり
        if search["AO"] == "AND"
          # AND検索
          Shop.joins(:shop_tag_relations).where("address LIKE ? AND name LIKE ? AND tag_id IN (?) ", "%#{search['area']}%", "%#{search['name']}%", search["tag_ids"])
              .group("shops.id").having("count(shops.id) = ?", search["tag_ids"].size).order("point_avg DESC")
        else
          # OR検索
          Shop.joins(:shop_tag_relations).where("address LIKE ? AND name LIKE ? AND tag_id IN (?) ", "%#{search['area']}%", "%#{search['name']}%", search["tag_ids"])
              .order("point_avg DESC")
        end
      else
        # タグ指定なし
        Shop.where("address LIKE ? AND name LIKE ? ", "%#{search['area']}%", "%#{search['name']}%").order("point_avg DESC")
      end
    end
  end

  # 店舗の平均ポイントを取得
  def self.cal_point_avg(shop)
    shop.posts.average(:point)
  end

  def self.area_conf
    area = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    area["東京"][0] = %w[三鷹 武蔵野 新宿]
    area["東京"][1] = %w[吉祥寺 池袋 千代田区]
    area["愛知"][0] = %w[名古屋 豊橋]
    area["愛知"][1] = %w[一宮 岡崎]
    area
  end

  def self.type_conf
    [[1, "/images/ramen.jpg"],
     [2, "/images/tsukemen.jpeg"],
     [3, "/images/aburasoba.jpeg"],
     [17, "/images/nibosi.jpeg"],
     [12, "/images/ziro.jpeg"]]
  end
end
