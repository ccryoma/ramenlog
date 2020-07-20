class Shop < ApplicationRecord
  belongs_to :member
  has_many  :posts
  validates :name,  presence: true, length: { maximum: 50 }
  validates :address,  presence: true, length: { maximum: 100 }
  validates :opening_ours,  length: { maximum: 255 }
  validates :parking,   length: { maximum: 50 }
  validates :member_id,  presence: true
end
