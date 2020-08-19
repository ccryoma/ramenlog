require "rails_helper"

RSpec.describe MemberMailer, type: :mailer do
  let(:member) { create(:member,:hanzawa) }

  describe "アカウントの有効化" do
    let(:mail) { MemberMailer.account_activation(member) }

    it "ヘッダ情報が正しく設定される" do
      member.activation_token = Member.new_token
      expect(mail.to).to have_text member.email
      expect(mail.from).to have_text "noreply@example.com"
      expect(mail.subject).to have_text "アカウントの有効化"
    end

    it "内容が正しく設定される" do
      member.activation_token = Member.new_token
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match member.name
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match member.activation_token
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match CGI.escape(member.email)
    end
  end

  describe "パスワード再設定" do
    let(:mail) { MemberMailer.password_reset(member) }

    it "ヘッダ情報が正しく設定される" do
      member.reset_token = Member.new_token
      expect(mail.to).to have_text member.email
      expect(mail.from).to have_text "noreply@example.com"
      expect(mail.subject).to have_text "パスワード再設定"
    end

    # メールプレビューのテスト
    it "内容が正しく設定される" do
      member.reset_token = Member.new_token
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match member.reset_token
      expect(mail.text_part.body.to_s.encode("UTF-8")).to match CGI.escape(member.email)
    end
  end
end