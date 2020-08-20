module RequestHelpers
  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:member_id].nil?
  end

  # テストユーザーとしてログインする
  def log_in_as(member)
    session[:member_id] = member.id
  end
end
