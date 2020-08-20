require "rails_helper"

RSpec.describe "会員登録", type: :system do
  context "無効な登録" do
    it "エラーメッセージが出力される" do
      visit signup_path

      fill_in "\u540D\u524D", with: "asdfas"
      fill_in "\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9", with: "member@invalid"
      fill_in "\u30D1\u30B9\u30EF\u30FC\u30C9", with: "foo"
      fill_in "\u30D1\u30B9\u30EF\u30FC\u30C9(\u518D\u5165\u529B)", with: "bar"
      click_button "\u767B\u9332"

      expect(page).to have_css "div#error_explanation"
      expect(page).to have_css "div.field_with_errors"
    end
  end

  # "有効な情報による登録"はrequest/member_spec.rbに記載
end
