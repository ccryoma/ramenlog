require "rails_helper"

RSpec.describe "ログイン", type: :system do
  let!(:member) { create(:member, :owada) }
  context "無効なログイン" do
    it "無効なパスワードでログインしようとして失敗する" do
      visit login_path

      fill_in "\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9", with: member.email
      fill_in "\u30D1\u30B9\u30EF\u30FC\u30C9", with: "invalid"
      click_button "\u30ED\u30B0\u30A4\u30F3"

      expect(page).to_not have_text "\u30ED\u30B0\u30A2\u30A6\u30C8"
    end
  end

  context "有効なログイン" do
    it "有効な情報でログインし、ログアウトする" do
      log_in_as(member)
      click_link "\u30ED\u30B0\u30A2\u30A6\u30C8"
      expect(page).to_not have_text "\u30ED\u30B0\u30A2\u30A6\u30C8"
    end
  end
end
