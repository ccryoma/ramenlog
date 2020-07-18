class Post < ApplicationRecord
  belongs_to :shop
  belongs_to :member
  validates :title,  presence: true, length: { maximum: 50 }
  validates :comment,  presence: true, length: { maximum: 3000 }
  validates :point,  presence: true, :numericality => { :greater_than_or_equal_to => 0,:less_than_or_equal_to => 5 } 
  
end
