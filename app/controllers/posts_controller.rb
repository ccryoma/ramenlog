class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = current_member.posts.build(posts_params)
    @post.images.attach(params[:post][:images])
    if @post.save
      flash[:success] = "レビューが投稿されました!"
      redirect_to shop_path(@post.shop_id)
    else
      flash[:danger] = "入力に誤りがあります。"
      redirect_to shop_path(@post.shop_id)
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer
  end


  private

    def posts_params
      params.require(:post).permit(:title, :point,:comment, :shop_id, images: [])
    end

end
