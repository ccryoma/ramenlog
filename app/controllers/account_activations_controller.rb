class AccountActivationsController < ApplicationController
  def edit
    member = Member.find_by(email: params[:email])
    if member && !member.activated? && member.authenticated?(:activation, params[:id])
      member.activate
      log_in member
      flash[:success] = "アカウントが有効化されました！"
      redirect_to member
    else
      flash[:danger] = "無効な有効化リンクです"
      redirect_to root_url
    end
  end
end
