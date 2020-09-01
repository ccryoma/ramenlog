require "rails_helper"

RSpec.describe "会員プロフィール", type: :system do
  let!(:admin) { create(:member, :admin) }
  let!(:member) { create(:member, :hanzawa) }

  context "管理ユーザーでログイン" do
    before do
      log_in_as(admin)
    end

    context "閲覧先が他人のページ" do
      it "プロフィールが表示され、削除リンクが表示される" do
        visit postlist_member_path(member)

        expect(page).to have_selector ".postlistMember_profile_right_name", text: member.name
        expect(page).to have_selector ".postlistMember_profile_right_posts", text: member.posts.count
        expect(page).to have_selector ".postlistMember_profile_right_shops", text: member.shops.count
        expect(page).to have_selector ".postlistMember_profile_right_delete", text: "削除"
        expect {
          click_link "削除", match: :first
        }.to change(Member, :count).by(-1)
      end
    end

    context "閲覧先が自身のページ" do
      it "削除リンクが表示されない" do
        visit postlist_member_path(admin)
        expect(page).to_not have_selector ".member_profile_left_delete", text: "削除"
      end
    end
  end

  context "一般会員でログイン中の場合" do
    it "削除リンクが表示されない" do
      log_in_as(member)
      visit postlist_member_path(member)
      expect(page).to_not have_selector ".member_profile_left_delete", text: "削除"
    end
  end
end
