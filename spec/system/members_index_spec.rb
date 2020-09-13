require "rails_helper"

RSpec.describe "会員一覧", type: :system do
  let!(:admin) { create(:member, :admin) }
  let!(:non_admin) { create(:member, :owada) }
  include_context "setup"
  before { members }

  context "管理ユーザーによるログイン" do
    it "会員一覧の表示、およびページネーションと削除リンクの表示" do
      log_in_as(admin)
      visit members_path
      expect(page).to have_css ".pagination"
      first_page_of_members = Member.paginate(page: 1)
      first_page_of_members.each do |member|
        expect(page).to have_link href: postlist_member_path(member)
        unless member == admin
          expect(page).to have_link href: member_path(member), text: "削除"
        end
      end
      expect {
        click_link "削除", match: :first
      }.to change(Member, :count).by(-1)
    end
  end

  context "一般会員によるログイン" do
    it "削除リンクが表示されない" do
      log_in_as(non_admin)
      visit members_path
      expect(page).to_not have_link text: "削除"
    end
  end
end
