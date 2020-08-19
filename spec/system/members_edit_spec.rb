require 'rails_helper'

RSpec.describe "会員情報編集", type: :system do
  let!(:member) { create(:member,:hanzawa) }

  context "無効な情報による編集" do
    it "編集に失敗し、エラーメッセージが表示される" do
      log_in_as(member)
      visit edit_member_path(member)

      fill_in '名前', with: ''
      fill_in 'メールアドレス', with: 'member@invalid'
      fill_in 'パスワード', with: 'foo'
      fill_in 'パスワード(再入力)', with: 'bar'
      click_button '更新'

      expect(page).to have_css 'div#error_explanation'
      expect(page).to have_css 'div.field_with_errors'
    end
  end

  context "有効な情報による編集" do
    it "編集に成功(フレンドリーフォワーディング)" do
      visit edit_member_path(member)
      log_in_as(member)

      name  = "Foo Bar"
      email = "foo@bar.com"
      fill_in '名前', with: name
      fill_in 'メールアドレス', with: email
      click_button '更新'
      
      visit edit_member_path(member)
      expect(name).to eq find_by_id('member_name').value
      expect(email).to eq find_by_id('member_email').value
    end
  end

end
