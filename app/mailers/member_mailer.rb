class MemberMailer < ApplicationMailer

  def account_activation(member)
    @member = member
    mail to: member.email, subject: "アカウントの有効化"
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
