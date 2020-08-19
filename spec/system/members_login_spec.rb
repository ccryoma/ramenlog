require 'rails_helper'

RSpec.describe "ログイン", type: :system do
  let!(:member) { create(:member,:owada) }
  context "無効なログイン" do
    it "無効なパスワードでログインしようとして失敗する" do
      visit login_path

      fill_in 'メールアドレス', with: member.email
      fill_in 'パスワード', with: 'invalid'
      click_button 'ログイン'

      expect(page).to_not have_text 'ログアウト'
    end
  end

  context "有効なログイン" do
    it "有効な情報でログインし、ログアウトする" do
      log_in_as(member)
      click_link 'ログアウト'
      expect(page).to_not have_text 'ログアウト'
    end
  end
end
