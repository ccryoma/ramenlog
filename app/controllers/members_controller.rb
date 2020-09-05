class MembersController < ApplicationController
  before_action :logged_in_member, only: %i[index edit update destroy]
  before_action :correct_member,   only: %i[edit update]
  before_action :admin_member,     only: :destroy

  def index
    @members = Member.paginate(page: params[:page])
  end

  def postlist_member
    @member = Member.find(params[:id])
    @posts = @member.posts.paginate(page: params[:page], per_page: 5)
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
    redirect_to root_url if current_member.email == "guest@example.com"
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to postlist_member_path(@member)
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

  # ログイン中の会員かどうか確認
  def correct_member
    @member = Member.find(params[:id])
    redirect_to(root_url) unless current_member?(@member)
  end
end
