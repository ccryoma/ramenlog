require "rails_helper"

RSpec.describe "Password_reset pages", type: :request do
  let(:member) { create(:member, :hanzawa) }

  it "パスワード再設定" do
    # メールアドレスが無効
    post password_resets_path, params: { password_reset: { email: "" } }
    expect(response).to render_template(:new)
    # メールアドレスが有効
    post password_resets_path, params: { password_reset: { email: member.email } }
    expect(response).to redirect_to root_path

    # パスワード再設定フォームのテスト
    member = assigns(:member)
    # メールアドレスが無効
    get edit_password_reset_path(member.reset_token, email: "")
    expect(response).to redirect_to root_path
    # メールアドレスが有効で、トークンが無効
    get edit_password_reset_path("wrong token", email: member.email)
    expect(response).to redirect_to root_path
    # メールアドレスもトークンも有効
    get edit_password_reset_path(member.reset_token, email: member.email)
    expect(response).to render_template(:edit)
    # 無効なパスワードとパスワード確認
    patch password_reset_path(member.reset_token),
        params: { email: member.email,
                  member: { password: "foobaz",
                            password_confirmation: "barquux" } }
    expect(response).to render_template(:edit)
    # パスワードが空
    patch password_reset_path(member.reset_token),
        params: { email: member.email,
                  member: { password: "",
                            password_confirmation: "" } }
    expect(response).to render_template(:edit)
    # 有効なパスワードとパスワード確認
    patch password_reset_path(member.reset_token),
        params: { email: member.email,
                  member: { password: "foobaz",
                            password_confirmation: "foobaz" } }
    expect(session[:member_id]).to eq member.id
    expect(response).to redirect_to postlistMember_path(member)
  end
end
