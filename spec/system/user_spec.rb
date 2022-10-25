require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'タスクを新規作成した場合' do
      it 'プロジェクトリストページに遷移できる' do
        visit new_user_registration_path
        fill_in '名前', with: "user1"
        fill_in 'Eメール', with: "user1@xxx.com"
        fill_in 'パスワード', with: "qqqqqqqq"
        fill_in 'パスワード（確認用）', with: "qqqqqqqq"
        click_button 'アカウント登録'
        expect(page).to have_content "Threee"
        expect(page).to have_content "アカウント登録が完了しました。"
      end
      context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
        it 'ログイン画面に遷移する' do
          visit projects_path
        expect(page).not_to have_content "プロジェクト"
        expect(page).to have_content "ログイン"
        expect(page).to have_content "名前"
        expect(page).to have_content "パスワード"
        end
      end
    end
  end
  describe 'セッション機能' do
    let!(:user1){FactoryBot.create(:user1)}
    before do
      
      visit new_user_session_path
      fill_in '名前', with: "user1"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end

    context 'ユーザー登録された情報をログイン画面に入力した場合' do
      it 'ログインができる' do
        expect(page).to have_content "Threee"
        expect(page).to have_content "ログインしました。"
        
      end
    end
    context 'ログインしている場合' do
      it 'マイページに遷移できる' do
        visit my_page_path(user1.id)
        expect(page).to have_content "user1"
      end
    end
    context 'ログインしていて、ログアウトボタンを押した場合' do
      it '作成済みのタスク一覧が表示される' do
        button = find('.logout')
        button.click
      end
    end
  end
  describe '管理者機能' do
    context '管理者権限を持ったユーザーが/adminのurlに行った場合' do
      it '管理者ページに遷移する' do
        admin = FactoryBot.create(:admin)
        visit new_user_session_path
        fill_in '名前', with: "admin"
        fill_in 'パスワード', with: "qqqqqqqq"
        button = find('.login')
        button.click
        visit rails_admin_path
        expect(page).to have_content "Admin"

      end
    end
  end
end