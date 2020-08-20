require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  def setup
    @member = members(:michael)
    @shop = @member.shops.build(name: "ExampleShop", address: "example_address", sheets: 20,
                                opening_ours: "9:00～22:00", parking: "Nothing")
  end

  test "should be valid" do
    assert @shop.valid?
  end

  test "name should be present" do
    @shop.name = "     "
    assert_not @shop.valid?
  end

  test "address should be present" do
    @shop.address = "     "
    assert_not @shop.valid?
  end

  test "name should not be too long" do
    @shop.name = "a" * 51
    assert_not @shop.valid?
  end

  test "address should not be too long" do
    @shop.address = "a" * 101
    assert_not @shop.valid?
  end

  test "opening_ours should not be too long" do
    @shop.opening_ours = "a" * 256
    assert_not @shop.valid?
  end

  test "parking should not be too long" do
    @shop.parking = "a" * 51
    assert_not @shop.valid?
  end
end
