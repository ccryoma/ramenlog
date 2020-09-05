class Post < ApplicationRecord
  belongs_to :shop
  belongs_to :member
  # belongs_to :latest_post, foreign_key: "latest_post_id", class_name: "Shop" 
  # belongs_to :latest_img, foreign_key: "latest_img_id", class_name: "Shop" 
  validates :title, presence: true, length: { maximum: 50 }
  validates :comment, presence: true, length: { maximum: 3000 }
  validates :point, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  has_many_attached :images
  default_scope -> { order(created_at: :desc) }
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "ファイルタイプはjpeg,gif,pngのいずれかとして下さい。" },
                     size: { less_than: 5.megabytes,
                             message: "ファイルサイズは5MB未満としてください。" }
end
