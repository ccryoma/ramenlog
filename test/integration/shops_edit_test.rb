require 'test_helper'

class ShopsEditTest < ActionDispatch::IntegrationTest
  def setup
    @member = members(:michael)
    @shop = shops(:Example)
  end

  test "unsuccessful edit" do
    log_in_as(@member)
    get edit_shop_path(@shop)
    assert_template 'shops/edit'
    patch shop_path(@shop), params: { shop: { name: "",
                                              address: "",
                                              opening_ours: "",
                                              sheets: 10,
                                              parking: "" } }

    assert_template 'shops/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "successful edit" do
    log_in_as(@member)
    get edit_shop_path(@shop)
    assert_template 'shops/edit'
    patch shop_path(@shop), params: { shop: { name: "EditName",
                                              address: "EditAddress",
                                              opening_ours: "EditOpeningOurs",
                                              sheets: 30,
                                              parking: "EditParking" } }
    assert_template 'shops/edit'
  end
end
