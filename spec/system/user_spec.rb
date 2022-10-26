require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'プロジェクトを新規作成した場合' do
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
    end
  end
  describe '非ユーザーアクセス制限機能' do
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    let!(:project1_true){FactoryBot.create(:project1_true, user_id: user1.id)}
    let!(:theme1){FactoryBot.create(:theme1, project_id: project1_true.id)}
    let!(:project2_true){FactoryBot.create(:project2_true, user_id: user1.id)}
    let!(:theme2){FactoryBot.create(:theme2, project_id: project2_true.id)}
    context 'ユーザがログインしていない場合' do
      it 'プロジェクトリストページに遷移できる' do
        visit projects_path
      expect(page).not_to have_content "ログイン"
      expect(page).to have_content "プロジェクト"
      expect(page).to have_content "リスト"
      expect(page).to have_content "名前"
      expect(page).to have_content "タイトル"
      expect(page).to have_content "作成日時"
    end
    context 'ユーザがログインしていない場合' do
      it 'テーマ閲覧画面に遷移できるがマイページには遷移できない' do
        visit projects_path
        expect(page).to have_content "プロジェクト"
        expect(page).to have_content "リスト"
        expect(page).to have_content "名前"
        expect(page).to have_content "タイトル"
        expect(page).to have_content "作成日時"
        all('tbody tr')[0].click_link 'プログラミングの学習'
        expect(page).to have_content "集中する"
        expect(page).to have_content "落ち着く"
        expect(page).to have_content "水分補給や食事を忘れない"
        visit projects_path
        all('tbody tr')[0].click_link 'user1'
        expect(page).to have_content "ログイン"
        visit projects_path
        click_link '新規作成'
        expect(page).to have_content "ログイン"
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
      it 'トップ画面に遷移する' do
        button = find('.logout')
        button.click
        expect(page).to have_content "Threee"
        expect(page).to have_content "今自分が気にしているテーマを３つ箇条書きにして書く。"
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