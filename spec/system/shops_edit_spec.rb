require 'rails_helper'

RSpec.describe "店舗情報編集", type: :system do
  let!(:member) { create(:member,:hanzawa) }
  let!(:shop) { create(:shop,:minato) }

  context "無効な情報の場合" do
    it "編集に失敗し、エラーメッセージが表示される" do
      log_in_as(member)
      visit edit_shop_path(shop)

      fill_in 'shop_name', with: ''
      fill_in 'shop_address', with: ''
      click_button '更新'

      expect(page).to have_css 'div#error_explanation'
      expect(page).to have_css 'div.field_with_errors'
    end
  end

  context "有効な情報の場合" do
    it "編集に成功する" do
      log_in_as(member)
      visit edit_shop_path(shop)

      name  = "Foobar"
      address = "FoobarAddress"
      fill_in 'shop_name', with: 'Foobar'
      fill_in 'shop_address', with: 'FoobarAddress'
      click_button '更新'
      
      visit edit_shop_path(shop)

      expect(name).to eq find_by_id('shop_name').value
      expect(address).to eq find_by_id('shop_address').value
    end
  end

end
