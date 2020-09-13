class PostsController < ApplicationController
  before_action :logged_in_member, only: %i[create destroy]

  def create
    @post = current_member.posts.build(posts_params)
    params[:score] = 0.0 if params[:score].empty?
    @post[:point] = params[:score]
    latest_img = @post if @post.images.attached?
    shop = @post.shop
    @post.transaction do
      @post.save!
      point_avg = Shop.cal_point_avg(shop)
      # 新規の登録画像があれば更新
      latest_img ||= shop.latest_img
      shop.update!(
        point_avg: point_avg,
        latest_post: @post,
        latest_img: latest_img
      )
    end
      flash[:success] = "レビューが投稿されました!"
      redirect_to postlist_path(shop)
    rescue => e
      logger.error e.message
      flash[:danger] = "入力に誤りがあります。"
      redirect_to request.referer
  end

  def destroy
    Post.transaction do
      shop = Post.find(params[:id]).shop
      # 削除まえに店舗の最新レビューと画像を更新
      Post.latest_reset(params[:id].to_i, shop)
      Post.find(params[:id]).destroy
      # 平均ポイントの再計算
      point_avg = Shop.cal_point_avg(shop)
      shop.update!(point_avg: point_avg)
    end
      flash[:success] = "レビューを削除しました"
      redirect_to request.referer
    rescue => e
      logger.error e.message
      flash[:danger] = "削除に失敗しました"
      redirect_to request.referer
  end

  private

  def posts_params
    params.require(:post).permit(:title, :point, :comment, :shop_id, images: [])
  end
end
