require 'test_helper'

class MemberMailerTest < ActionMailer::TestCase
  test "account_activation" do
    member = members(:michael)
    member.activation_token = Member.new_token
    mail = MemberMailer.account_activation(member)
    assert_equal "アカウントの有効化", mail.subject
    assert_equal [member.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match member.name,               mail.text_part.body.to_s.encode("UTF-8")
    assert_match member.activation_token,   mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(member.email),  mail.text_part.body.to_s.encode("UTF-8")
  end

  test "password_reset" do
    member = members(:michael)
    member.reset_token = Member.new_token
    mail = MemberMailer.password_reset(member)
    assert_equal "パスワード再設定", mail.subject
    assert_equal [member.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match member.reset_token,        mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(member.email),  mail.text_part.body.to_s.encode("UTF-8")
  end
end
