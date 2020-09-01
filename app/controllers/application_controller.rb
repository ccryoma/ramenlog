class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # ユーザーのログインを確認する
  def logged_in_member
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  # 管理者かどうか確認
  def admin_member
    redirect_to(root_url) unless current_member.admin?
  end
end
