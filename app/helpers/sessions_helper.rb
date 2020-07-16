module SessionsHelper
  
  # 渡された会員でログインする
  def log_in(member)
    session[:member_id] = member.id
  end

  # 現在ログイン中の会員を返す（いる場合）
  def current_member
    if session[:member_id]
      @current_member ||= Member.find_by(id: session[:member_id])
    end
  end

  # 会員がログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_member.nil?
  end
  
  # 現在の会員をログアウトする
  def log_out
    session.delete(:member_id)
    @current_member = nil
  end
end
