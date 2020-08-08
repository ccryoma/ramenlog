class ShopTagRelation < ApplicationRecord
  belongs_to :shop
  belongs_to :tag
end
