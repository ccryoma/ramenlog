class Shop < ApplicationRecord
  belongs_to :member
  has_many  :posts
  has_many  :shop_tag_relations, dependent: :destroy
  has_many  :tags, through: :shop_tag_relations
  validates :name,  presence: true, length: { maximum: 50 }
  validates :address,  presence: true, length: { maximum: 100 }
  validates :opening_ours,  length: { maximum: 255 }
  validates :parking,   length: { maximum: 50 }
  validates :member_id,  presence: true

  def save_tags(save_tags)
    self.tags.nil? ? current_tags = [] : current_tags = self.tags.pluck(:id)
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
end
