class MembersController < ApplicationController
  before_action :logged_in_member, only: [:index, :edit, :update, :destroy]
  before_action :correct_member,   only: [:edit, :update]
  before_action :admin_member,     only: :destroy
  
  def index
    @members = Member.paginate(page: params[:page])
  end
  
  def show
    @member = Member.find(params[:id])
  end
  
  def new
    @member = Member.new
  end
  
  def create
    @member = Member.new(member_params)
    if @member.save
      log_in @member
      flash[:success] = "ラーメンログへようこそ！"
      redirect_to @member
    else
      render 'new'
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to @member
    else
      render 'edit'
    end
  end

  def destroy
    Member.find(params[:id]).destroy
    flash[:success] = "会員を削除しました"
    redirect_to members_url
  end

  private

    def member_params
      params.require(:member).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    # beforeアクション

    # ログイン済み会員かどうか確認
    def logged_in_member
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
    
    # 正しい会員かどうか確認
    def correct_member
      @member = Member.find(params[:id])
      redirect_to(root_url) unless current_member?(@member)
    end
    
    # 管理者かどうか確認
    def admin_member
      redirect_to(root_url) unless current_member.admin?
    end
end
