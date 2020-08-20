require "rails_helper"

RSpec.describe "新規店舗登録", type: :system do
  let!(:member) { create(:member, :hanzawa) }

  context "無効な情報の場合" do
    it "登録に失敗し、エラーメッセージが表示される" do
      log_in_as(member)
      visit registration_path

      expect {
        fill_in "shop_name", with: ""
        fill_in "shop_address", with: ""
        click_button "\u767B\u9332"
      }.to change(Shop, :count).by(0)

      expect(page).to have_css "div#error_explanation"
      expect(page).to have_css "div.field_with_errors"
    end
  end

  context "有効な情報の場合" do
    it "登録に成功する" do
      log_in_as(member)
      visit registration_path

      expect {
        fill_in "shop_name", with: "Foobar"
        fill_in "shop_address", with: "FoobarAddress"
        click_button "\u767B\u9332"
      }.to change(Shop, :count).by(1)
    end
  end
end
