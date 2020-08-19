module SystemHelpers
   
  # ログイン中の場合にtrueを返す
  def is_logged_in?
    expect(page).to have_text 'ログアウト'
  end

  # テストユーザーとしてログインする
  def log_in_as(member)
    visit login_path
    fill_in 'メールアドレス', with: member.email
    fill_in 'パスワード', with: member.password
    click_button 'ログイン'
    expect(page).to have_text 'ログアウト'
  end
  
end