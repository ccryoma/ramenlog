class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @post = current_member.posts.build(posts_params)
    @post.images.attach(params[:post][:images])
    if @post.save
      flash[:success] = "レビューが投稿されました!"
    else
      flash[:danger] = "入力に誤りがあります。"
    end
    redirect_to shop_path(@post.shop_id)
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referer
  end

  private

  def posts_params
    params.require(:post).permit(:title, :point, :comment, :shop_id, images: [])
  end
end
