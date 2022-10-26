require 'rails_helper'
RSpec.describe 'プロジェクト管理機能', type: :system do
  describe '新規作成機能' do
    let!(:user1){FactoryBot.create(:user1)}
    before do
      visit new_user_session_path
      fill_in '名前', with: "user1"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end
    context 'プロジェクトとテーマを新規作成した場合' do
      it '作成したプロジェクトとテーマが表示される' do
        visit top_path
        link_new = find('.new_project')
        link_new.click
        fill_in 'project_title', with: '日記'
        fill_in 'project_themes_attributes_0_first_theme', with: '思いついたことをとりあえず書く'
        fill_in 'project_themes_attributes_0_second_theme', with: '一行でもいいから毎日書く'
        fill_in 'project_themes_attributes_0_third_theme', with: 'できれば自分の感情について書く'
        click_button '登録する'
        visit my_page_path(user1)
        expect(page).to have_content "日記"
        link = find('a', text: '日記')
        link.click
        expect(page).to have_content "日記"
      end
    end
  end
  describe '一覧表示機能' do
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    let!(:project1_true){FactoryBot.create(:project1_true, user_id: user1.id)}
    let!(:theme1){FactoryBot.create(:theme1, project_id: project1_true.id)}
    let!(:project2_true){FactoryBot.create(:project2_true, user_id: user1.id)}
    let!(:theme2){FactoryBot.create(:theme2, project_id: project2_true.id)}
    before do
      visit new_user_session_path
      fill_in '名前', with: "user2"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのプロジェクト一覧が表示される' do
        visit projects_path
        expect(page).to have_content "健康"
        expect(page).to have_content "プログラミングの学習"
      end
    end
  end
  describe '詳細表示機能' do
    
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    let!(:project3){FactoryBot.create(:project3, user_id: user2.id)}
    let!(:theme3){FactoryBot.create(:theme3, project_id: project3.id)}
    let!(:project1){FactoryBot.create(:project1, user_id: user1.id)}
    let!(:theme1){FactoryBot.create(:theme1, project_id: project1.id)}
    let!(:project2){FactoryBot.create(:project2, user_id: user1.id)}
    let!(:theme2){FactoryBot.create(:theme2, project_id: project2.id)}

    before do
      visit new_user_session_path
      fill_in '名前', with: "user1"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end
    context 'プロジェクトの編集を行った場合' do
      it 'その編集が適用される' do
        visit my_page_path(user1.id)
        expect(page).not_to have_content "パソコンの作業"
        expect(page).to have_content "プログラミングの学習"
        all('tbody tr')[0].click_link '名前を編集する'
        fill_in 'project_title', with: 'パソコンの作業'
        click_button '更新する'
        expect(page).to have_content "パソコンの作業"
        expect(page).not_to have_content "プログラミングの学習"
      end
    end
  end
  describe 'プロジェクト削除機能' do
    
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    let!(:project3){FactoryBot.create(:project3, user_id: user2.id)}
    let!(:theme3){FactoryBot.create(:theme3, project_id: project3.id)}
    let!(:project1){FactoryBot.create(:project1, user_id: user1.id)}
    let!(:theme1){FactoryBot.create(:theme1, project_id: project1.id)}
    let!(:project2){FactoryBot.create(:project2, user_id: user1.id)}
    let!(:theme2){FactoryBot.create(:theme2, project_id: project2.id)}
    
    before do
      visit new_user_session_path
      fill_in '名前', with: "user1"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end
    context 'プロジェクトの削除を行った場合' do
      it 'その削除が適用される' do
        visit my_page_path(user1.id)
        expect(page).to have_content "プログラミングの学習"
        all('tbody tr')[0].click_link '削除する'
        page.accept_confirm
        expect(page).not_to have_content "プログラミングの学習"
        
      end
    end
  end
  describe 'アクセス制限機能' do
    
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    let!(:project3){FactoryBot.create(:project3, user_id: user2.id)}
    let!(:theme3){FactoryBot.create(:theme3, project_id: project3.id)}
    let!(:project1){FactoryBot.create(:project1, user_id: user1.id)}
    let!(:theme1){FactoryBot.create(:theme1, project_id: project1.id)}
    let!(:project2){FactoryBot.create(:project2, user_id: user1.id)}
    let!(:theme2){FactoryBot.create(:theme2, project_id: project2.id)}

    before do
      visit new_user_session_path
      fill_in '名前', with: "user1"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end
    context '他の人のプロジェクトの編集画面に行く場合' do
      it 'その人のマイページに遷移される' do
        visit edit_project_path(project3)
        expect(current_path).to eq my_page_path(user2)
      end
    end
    context 'プロジェクト一覧画面とマイページから削除ボタンを探した場合' do
      it '自分のプロジェクトの削除リンクしかない' do
        visit projects_path
        expect(all('tbody tr')[0]).not_to have_content '削除する'
        expect(all('tbody tr')[1]).not_to have_content '削除する'
        expect(all('tbody tr')[2]).not_to have_content '削除する'
        visit my_page_path(user1.id)
        expect(all('tbody tr').length).to eq 2
        expect(all('tbody tr')[0]).to have_content project2.title
        expect(all('tbody tr')[0]).to have_content '削除する'
        expect(all('tbody tr')[1]).to have_content project1.title
        expect(all('tbody tr')[1]).to have_content '削除する'
        expect(page).not_to have_content project3.title
      end
    end
  end
  describe 'タイトル検索機能' do
    
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    let!(:project3_true){FactoryBot.create(:project3_true, user_id: user2.id)}
    let!(:theme3){FactoryBot.create(:theme3, project_id: project3_true.id)}
    let!(:project1_true){FactoryBot.create(:project1_true, user_id: user1.id)}
    let!(:theme1){FactoryBot.create(:theme1, project_id: project1_true.id)}
    let!(:project2_true){FactoryBot.create(:project2_true, user_id: user1.id)}
    let!(:theme2){FactoryBot.create(:theme2, project_id: project2_true.id)}

    before do
      visit new_user_session_path
      fill_in '名前', with: "user1"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end
    context 'タイトル検索フォームに入力して送信した場合' do
      it '検索（およびあいまい検索）ができる' do
        visit projects_path
        expect(page).to have_content '健康'
        expect(page).to have_content 'プログラミングの学習'
        expect(page).to have_content 'メモを取る'
        fill_in 'タイトル検索', with: "健康"
        click_button '検索'
        expect(page).to have_content '健康'
        expect(page).not_to have_content 'プログラミングの学習'
        expect(page).not_to have_content 'メモを取る'
        visit projects_path
        fill_in 'タイトル検索', with: "プロ"
        click_button '検索'
        expect(page).to have_content 'プログラミングの学習'
        expect(page).not_to have_content '健康'
        expect(page).not_to have_content 'メモを取る'
      end
    end
    end
  describe '公開機能' do
    
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    let!(:project3){FactoryBot.create(:project3, user_id: user2.id)}
    let!(:theme3){FactoryBot.create(:theme3, project_id: project3.id)}
    let!(:project1){FactoryBot.create(:project1, user_id: user1.id)}
    let!(:theme1){FactoryBot.create(:theme1, project_id: project1.id)}
    let!(:project2){FactoryBot.create(:project2, user_id: user1.id)}
    let!(:theme2){FactoryBot.create(:theme2, project_id: project2.id)}

    before do
      visit new_user_session_path
      fill_in '名前', with: "user1"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end
    context 'マイページで' do
      it 'その人のマイページに遷移される' do
        visit projects_path
        expect(page).not_to have_content 'プログラミングの学習'
        expect(page).not_to have_content '健康'
        visit my_page_path(user1)
        all('tbody tr')[0].click_link '公開する'
        visit projects_path
        expect(page).to have_content 'プログラミングの学習'
        expect(page).not_to have_content '健康'
        visit my_page_path(user1)
        all('tbody tr')[1].click_link '公開する'
        visit projects_path
        expect(page).to have_content 'プログラミングの学習'
        expect(page).to have_content '健康'
      end
    end
  end
end