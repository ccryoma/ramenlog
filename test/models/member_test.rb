require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  def setup
    @member = Member.new(name: "Example Member", email: "member@example.com",
                         password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @member.valid?
  end

  test "name should be present" do
    @member.name = "     "
    assert_not @member.valid?
  end

  test "email should be present" do
    @member.email = "     "
    assert_not @member.valid?
  end

  test "name should not be too long" do
    @member.name = "a" * 51
    assert_not @member.valid?
  end

  test "email should not be too long" do
    @member.email = "a" * 244 + "@example.com"
    assert_not @member.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[member@example,com user_at_foo.org member.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @member.email = invalid_address
      assert_not @member.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_member = @member.dup
    @member.save
    assert_not duplicate_member.valid?
  end

  test "password should be present (nonblank)" do
    @member.password = @member.password_confirmation = " " * 6
    assert_not @member.valid?
  end

  test "password should have a minimum length" do
    @member.password = @member.password_confirmation = "a" * 5
    assert_not @member.valid?
  end

  test "authenticated? should return false for a member with nil digest" do
    assert_not @member.authenticated?(:remember, '')
  end
end
