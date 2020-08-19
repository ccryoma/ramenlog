require 'rails_helper'

RSpec.describe "会員登録", type: :system do
  context "無効な登録" do
    it "エラーメッセージが出力される" do
      visit signup_path

      fill_in '名前', with: 'asdfas'
      fill_in 'メールアドレス', with: 'member@invalid'
      fill_in 'パスワード', with: 'foo'
      fill_in 'パスワード(再入力)', with: 'bar'
      click_button '登録'

      expect(page).to have_css 'div#error_explanation'
      expect(page).to have_css 'div.field_with_errors'
    end
  end

  # "有効な情報による登録"はrequest/member_spec.rbに記載

end
