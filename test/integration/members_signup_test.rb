require 'test_helper'

class MembersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Member.count' do
      post members_path, params: { member: { name:  "",
                                         email: "member@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'members/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'Member.count', 1 do
      post members_path, params: { member: { name:  "Example User",
                                         email: "member@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'members/show'
  end
end
