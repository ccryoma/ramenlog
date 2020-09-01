class SessionsController < ApplicationController
  def new; end

  def create
    member = Member.find_by(email: params[:session][:email].downcase)
    if member&.authenticate(params[:session][:password])
      if member.activated?
        log_in member
        params[:session][:remember_me] == "1" ? remember(member) : forget(member)
        flash[:success] = "ログインしました。"
        redirect_back_or postlist_member_path(member)
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

  def new_guest
    member = Member.find_or_create_by!(email: "guest@example.com") do |m|
      m.name = "テストユーザー"
      m.password = SecureRandom.urlsafe_base64
      m.activated = true
    end
    log_in member
    flash[:success] = "ゲストユーザーとしてログインしました。"
    redirect_to request.referer
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
