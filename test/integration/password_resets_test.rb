require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @member = members(:michael)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    assert_select 'input[name=?]', 'password_reset[email]'
    # メールアドレスが無効
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # メールアドレスが有効
    post password_resets_path,
         params: { password_reset: { email: @member.email } }
    assert_not_equal @member.reset_digest, @member.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # パスワード再設定フォームのテスト
    member = assigns(:member)
    # メールアドレスが無効
    get edit_password_reset_path(member.reset_token, email: "")
    assert_redirected_to root_url
    # 無効な会員
    member.toggle!(:activated)
    get edit_password_reset_path(member.reset_token, email: member.email)
    assert_redirected_to root_url
    member.toggle!(:activated)
    # メールアドレスが有効で、トークンが無効
    get edit_password_reset_path('wrong token', email: member.email)
    assert_redirected_to root_url
    # メールアドレスもトークンも有効
    get edit_password_reset_path(member.reset_token, email: member.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", member.email
    # 無効なパスワードとパスワード確認
    patch password_reset_path(member.reset_token),
          params: { email: member.email,
                    member: { password:              "foobaz",
                            password_confirmation: "barquux" } }
    assert_select 'div#error_explanation'
    # パスワードが空
    patch password_reset_path(member.reset_token),
          params: { email: member.email,
                    member: { password:              "",
                            password_confirmation: "" } }
    assert_select 'div#error_explanation'
    # 有効なパスワードとパスワード確認
    patch password_reset_path(member.reset_token),
          params: { email: member.email,
                    member: { password:              "foobaz",
                            password_confirmation: "foobaz" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to member
  end
end
