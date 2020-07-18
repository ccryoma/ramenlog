require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @member = members(:michael)
    @shop = @member.shops.build(name: "ExampleShop", address: "example_address",sheets:20,
                                    opening_ours: "9:00～22:00", parking: "Nothing")
    @post = @member.posts.build(title: "ExampleShop", comment: "comment",point:2.0,shop: @shop)
  end
  
  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = "     "
    assert_not @post.valid?
  end

  test "comment should be present" do
    @post.comment = "     "
    assert_not @post.valid?
  end

  test "point should be present" do
    @post.point = "     "
    assert_not @post.valid?
  end
  
  test "title should not be too long" do
    @post.title = "a" * 51
    assert_not @post.valid?
  end
  
  test "comment should not be too long" do
    @post.comment = "a" * 3001
    assert_not @post.valid?
  end

  test "point should not be greater_than_or_equal_to" do
    @post.point = 5.1
    assert_not @post.valid?
  end

  test "point should not be less_than_or_equal_to" do
    @post.point = -0.1
    assert_not @post.valid?
  end

end
