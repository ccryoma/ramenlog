require "rails_helper"

RSpec.describe "店舗一覧", type: :system do
  let!(:admin) { create(:member, :admin) }
  let!(:non_admin) { create(:member, :owada) }
  include_context "setup"
  before { shops }

  context "管理ユーザーの場合" do
    it "店舗一覧の表示、およびページネーションと削除リンクの表示" do
      log_in_as(admin)
      visit shops_path
      expect(page).to have_css ".pagination"
      expect(page).to have_css ".shop"
      expect {
        click_link "\u3053\u306E\u5E97\u8217\u3092\u524A\u9664", match: :first
      }.to change(Shop, :count).by(-1)
    end
  end

  context "一般会員の場合" do
    it "削除リンクが表示されない" do
      log_in_as(non_admin)
      visit shops_path
      expect(page).to_not have_link text: "\u3053\u306E\u5E97\u8217\u3092\u524A\u9664"
    end
  end
end
