class MemberMailer < ApplicationMailer

  def account_activation(member)
    @member = member
    mail to: member.email, subject: "アカウントの有効化"
  end

  def password_reset(member)
    @member = member
    mail to: member.email, subject: "パスワード再設定"
  end
end
