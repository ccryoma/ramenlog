module SystemHelpers
  # ログイン中の場合にtrueを返す
  def is_logged_in?
    expect(page).to have_text "\u30ED\u30B0\u30A2\u30A6\u30C8"
  end

  # テストユーザーとしてログインする
  def log_in_as(member)
    visit login_path
    fill_in "\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9", with: member.email
    fill_in "\u30D1\u30B9\u30EF\u30FC\u30C9", with: member.password
    click_button "\u30ED\u30B0\u30A4\u30F3"
    expect(page).to have_text "\u30ED\u30B0\u30A2\u30A6\u30C8"
  end
end
