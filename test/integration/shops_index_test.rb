require 'test_helper'

class ShopsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin     = members(:michael)
    @non_admin = members(:archer)
    @shop = shops(:Example)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get shops_path
    assert_template 'shops/index'
    assert_select 'div.pagination'
    first_page_of_shops = Shop.paginate(page: 1)
    first_page_of_shops.each do |shop|
      assert_select 'a[href=?]', shop_path(shop), text: shop.name
      assert_select 'a[href=?]', shop_path(shop), text: '削除'
    end
    assert_difference 'Shop.count', -1 do
      delete shop_path(@shop)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get shops_path
    assert_select 'a', text: 'delete', count: 0
  end
end
