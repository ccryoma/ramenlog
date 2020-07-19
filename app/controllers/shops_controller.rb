class ShopsController < ApplicationController  
  
  def index
    @shops = Shop.eager_load(:posts).select("shops.*, posts.*,round(avg(point),1) as point_avg").group("shops.id").order("point_avg DESC").paginate(page: params[:page],per_page: 20) 
  end
  
  def show
    @shop = Shop.find(params[:id])
    @shop_point = Post.where(shop_id: @shop.id).average("point")
    @post = Post.new
    @posts = @shop.posts
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_member.shops.build(shop_params)
    if @shop.save
      flash[:success] = "店舗を登録しました！"
      redirect_to shop_path(@shop.id)
    else
      render 'new'
    end
  end
  
  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:success] = "店舗情報が更新されました"
      redirect_to @shop
    else
      render 'edit'
    end
  end

  def destroy
    Shop.find(params[:id]).destroy
    flash[:success] = "店舗を削除しました"
    redirect_to shops_url
  end
  
  private

    def shop_params
      params.require(:shop).permit(:name, :address, :opening_ours, :sheets, :parking)
    end
end
