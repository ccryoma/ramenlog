class SessionsController < ApplicationController
  def new; end

  def create
    member = Member.find_by(email: params[:session][:email].downcase)
    if member&.authenticate(params[:session][:password])
      if member.activated?
        log_in member
        params[:session][:remember_me] == "1" ? remember(member) : forget(member)
        redirect_back_or member
      else
        message  = "アカウントが有効化されていません。"
        message += "有効化リンクの記載されたメールをご確認ください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "メールアドレスとパスワードの組み合わせが不正です。"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
