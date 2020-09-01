class PasswordResetsController < ApplicationController
  before_action :member_get,   only: %i[edit update]
  before_action :valid_member, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new; end

  def create
    @member = Member.find_by(email: params[:password_reset][:email].downcase)
    if @member
      @member.create_reset_digest
      @member.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送信しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが登録されていません。"
      render "new"
    end
  end

  def edit; end

  def update
    if params[:member][:password].empty?
      @member.errors.add(:password, :blank)
      render "edit"
    elsif @member.update(member_params)
      log_in @member
      flash[:success] = "パスワードを変更しました。"
      redirect_to postlist_member_path(@member)
    else
      render "edit"
    end
  end

  private

  def member_params
    params.require(:member).permit(:password, :password_confirmation)
  end

  # beforeフィルタ
  def member_get
    @member = Member.find_by(email: params[:email])
  end

  # 正しい会員かどうか確認する
  def valid_member
    unless @member&.activated? &&
           @member&.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    if @member.password_reset_expired?
      flash[:danger] = "パスワード再設定の期限が切れています。"
      redirect_to new_password_reset_url
    end
  end
end
