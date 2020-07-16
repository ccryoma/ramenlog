module SessionsHelper
  
  # 渡された会員でログインする
  def log_in(member)
    session[:member_id] = member.id
  end

  # 会員のセッションを永続的にする
  def remember(member)
    member.remember
    cookies.permanent.signed[:member_id] = member.id
    cookies.permanent[:remember_token] = member.remember_token
  end


  # セッション、もしくは記憶トークンcookieに対応する会員を返す
  def current_member
    if (member_id = session[:member_id])
      @current_member ||= Member.find_by(id: member_id)
    elsif (member_id = cookies.signed[:member_id])
      member = Member.find_by(id: member_id)
      if member && member.authenticated?(:remember,cookies[:remember_token])
        log_in member
        @current_member = member
      end
    end
  end
  
  # 渡されたユーザーがログイン中の会員であればtrueを返す
  def current_member?(member)
    member && member == current_member
  end
  # 会員がログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_member.nil?
  end
  
  # 永続的セッションを破棄する
  def forget(member)
    member.forget
    cookies.delete(:member_id)
    cookies.delete(:remember_token)
  end
  
  # 現在の会員をログアウトする
  def log_out
    forget(current_member)
    session.delete(:member_id)
    @current_member = nil
  end
  
  # 記憶したURL（もしくはデフォルト値）にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
