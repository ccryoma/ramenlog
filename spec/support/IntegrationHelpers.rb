module IntegrationHelpers

  #class ActiveSupport::TestCase
    
      # ログイン中の場合にtrueを返す
      def is_logged_in?
        expect(page).to have_text 'ログアウト'
      end
    
      # テストユーザーとしてログインする
      def log_in_as(member)
        visit login_path
        fill_in 'メールアドレス', with: member.email
        fill_in 'パスワード', with: member.password
        click_button 'ログイン'
        expect(page).to have_text 'ログアウト'
      end
   # end
    
   # class ActionDispatch::IntegrationTest
=begin     
      # テストユーザーとしてログインする
      def log_in_as(member, password: 'password', remember_me: '1')
        post login_path, params: { session: { email: member.email,
                                              password: password,
                                              remember_me: remember_me } }
      end
=end
  #  end
end