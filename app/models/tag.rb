class Tag < ApplicationRecord
  has_many :shop_tag_relations, dependent: :destroy
  has_many :shops, through: :shop_tag_relations
  self.inheritance_column = :_type_disabled 

  def self.name_set(tag_ids)
    tags = []
    tag_ids.each_with_index do |tag, id|
      tags[id] = Tag.find(tag).name
    end
    return tags
  end
end
