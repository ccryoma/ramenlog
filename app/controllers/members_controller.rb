class MembersController < ApplicationController
  before_action :logged_in_member, only: %i[index edit update destroy]
  before_action :correct_member,   only: %i[edit update]
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
      @member.send_activation_email
      flash[:info] = "メールを確認してアカウントを有効化してください"
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.image.attach(params[:member][:image])
    if @member.update(member_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to @member
    else
      render "edit"
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
                                 :password_confirmation, :image)
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
