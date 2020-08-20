require "rails_helper"

RSpec.describe "Member pages", type: :request do
  it "有効な情報による登録" do
    expect {
      post members_path, params: { member: { name: "ExampleMember",
                                             email: "member@example.com",
                                             password: "password",
                                             password_confirmation: "password" } }
    }.to change(Member, :count).by(1)
    expect(response).to redirect_to root_path
    member = assigns(:member)
    expect(member.activated?).to be_falsey
    # 有効化していない状態でログインしてみる
    log_in_as(member)
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: member.email)
    expect(session[:member_id]).to be_falsey
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(member.activation_token, email: "wrong")
    expect(session[:member_id]).to be_falsey
    # 有効化トークンが正しい場合
    get edit_account_activation_path(member.activation_token, email: member.email)
    expect(session[:member_id]).to eq member.id
    expect(member.name).to eq "ExampleMember"
    expect(member.email).to eq "member@example.com"
    expect(member.password).to eq "password"
  end

  # "無効な情報による登録"はsystem/members_signup_spec.rbに記載
end
