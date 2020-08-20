require "rails_helper"

RSpec.describe "会員情報編集", type: :system do
  let!(:member) { create(:member, :hanzawa) }

  context "無効な情報による編集" do
    it "編集に失敗し、エラーメッセージが表示される" do
      log_in_as(member)
      visit edit_member_path(member)

      fill_in "\u540D\u524D", with: ""
      fill_in "\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9", with: "member@invalid"
      fill_in "\u30D1\u30B9\u30EF\u30FC\u30C9", with: "foo"
      fill_in "\u30D1\u30B9\u30EF\u30FC\u30C9(\u518D\u5165\u529B)", with: "bar"
      click_button "\u66F4\u65B0"

      expect(page).to have_css "div#error_explanation"
      expect(page).to have_css "div.field_with_errors"
    end
  end

  context "有効な情報による編集" do
    it "編集に成功(フレンドリーフォワーディング)" do
      visit edit_member_path(member)
      log_in_as(member)

      name  = "Foo Bar"
      email = "foo@bar.com"
      fill_in "\u540D\u524D", with: name
      fill_in "\u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9", with: email
      click_button "\u66F4\u65B0"

      visit edit_member_path(member)
      expect(name).to eq find_by_id("member_name").value
      expect(email).to eq find_by_id("member_email").value
    end
  end
end
