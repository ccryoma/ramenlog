require 'test_helper'

class ShopsRegistrationTest < ActionDispatch::IntegrationTest
  def setup
    @member = members(:michael)
  end

  test "invalid registration information" do
    log_in_as(@member)
    get registration_path
    assert_no_difference 'Shop.count' do
      post shops_path, params: { shop: { name: "",
                                         address: "",
                                         opening_ours: "",
                                         sheets: 0,
                                         parking: "" } }
    end
    assert_template 'shops/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid registration information" do
    log_in_as(@member)
    get registration_path
    assert_difference 'Shop.count', 1 do
      post shops_path, params: { shop: { name: "ExampleShop",
                                         address: "ExampleAddress",
                                         opening_ours: "9:00～20:00",
                                         sheets: 10,
                                         parking: "Nothing" } }
    end
    follow_redirect!
    assert_template 'shops/show'
  end
end
