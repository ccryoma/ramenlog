class ShopsController < ApplicationController
  def search
    @shops = Shop.search(post_params).paginate(page: params[:page], per_page: 20)
  end

  def map
    @shops = Shop.search(post_params)
    @find = true
    if @shops.empty? || (params[:post][:area].empty? && params[:post][:name].empty? && params[:post][:tag_ids].nil?)
      @find = false
    end
    @shops = Shop.search("") if @shops.empty?
  end

  def index
    @shops = Shop.eager_load(:posts).select("shops.*, posts.*,round(avg(point),1) as point_avg")
                 .group("shops.id").order("point_avg DESC").paginate(page: params[:page], per_page: 20)
  end

  def show
    @shop = Shop.find(params[:id])
    @shop_point = Post.where(shop_id: @shop.id).average("point")
    @shop_point ? @shop_point = @shop_point.round(1) : @shop_point = "未評価"
    @post = Post.new
    @posts = @shop.posts
  end

  def postlist
    @shop = Shop.find(params[:id])
    @shop_point = Post.where(shop_id: @shop.id).average("point")
    @shop_point ? @shop_point = @shop_point.round(1) : @shop_point = "未評価"
    @post = Post.new
    @posts = @shop.posts.paginate(page: params[:page], per_page: 5)
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_member.shops.build(shop_params)
    if @shop.save
      @shop.save_tags(params[:shop][:tag_ids])
      flash[:success] = "店舗を登録しました！"
      redirect_to shop_path(@shop.id)
    else
      render "new"
    end
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      @shop.save_tags(params[:shop][:tag_ids])
      flash[:success] = "店舗情報が更新されました"
      redirect_to @shop
    else
      render "edit"
    end
  end

  def destroy
    Shop.find(params[:id]).destroy
    flash[:success] = "店舗を削除しました"
    redirect_to shops_url
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :address, :opening_ours, :sheets, :parking, :latitude, :longitude, tag_ids: [])
  end

  def post_params
    params.require(:post).permit(:area, :name, :AO, tag_ids: [])
  end
end
