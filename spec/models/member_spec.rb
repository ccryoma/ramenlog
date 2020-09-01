require "rails_helper"

RSpec.describe Member, type: :model do
  let(:member) { build(:member, :admin) }

  it "Memberは有効である" do
    expect(member).to be_valid
  end

  it "nameは必須である" do
    member.name = "   "
    expect(member).to_not be_valid
  end

  it "emailは必須である" do
    member.email = "   "
    expect(member).to_not be_valid
  end

  it "nameは50文字以内である" do
    member.name = "a" * 51
    expect(member).to_not be_valid
  end

  it "emailは255文字以内である" do
    member.email = "a" * 244 + "@example.com"
    expect(member).to_not be_valid
  end

  it "emailバリデーションは無効なアドレスを拒否する" do
    invalid_addresses = %w[member.com member@ @mamber]
    invalid_addresses.each do |invalid_address|
      member.email = invalid_address
      expect(member).to_not be_valid
    end
  end

  it "emailは一意である" do
    duplicate_member = member.dup
    member.save
    expect(duplicate_member).to_not be_valid
  end

  it "passwordは必須である" do
    member.password = member.password_confirmation = " " * 6
    expect(member).to_not be_valid
  end

  it "authenticated?メソッドはnilダイジェストを持つmemberに対してfalseを返す" do
    expect(member.authenticated?(:remember, "")).to be_falsey
  end
end
