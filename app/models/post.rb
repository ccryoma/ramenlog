class Post < ApplicationRecord
  belongs_to :shop
  belongs_to :member
  validates :title, presence: true, length: { maximum: 50 }
  validates :comment, presence: true, length: { maximum: 3000 }
  validates :point, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  has_many_attached :images
  default_scope -> { order(created_at: :desc) }
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "ファイルタイプはjpeg,gif,pngのいずれかとして下さい。" },
                     size: { less_than: 5.megabytes,
                             message: "ファイルサイズは5MB未満としてください。" }

  def self.latest_reset(delete_post_id, shop)
    posts = shop.posts.order(:created_at).offset(1)
    # 最新レビューのリセット
    if shop.latest_post_id == delete_post_id
      latest_post = nil
      latest_post = posts[0] if posts
      shop.update!(latest_post: latest_post)
    end
    # 最新画像のリセット
    if shop.latest_img_id == delete_post_id
      latest_img = nil
      posts.each do |post|
        if post.images.attached? && shop.latest_img_id != post.id
          latest_img = post
          break;
        end
      end
      shop.update!(latest_img: latest_img)
    end
  end

end
