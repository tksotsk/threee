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
        expect(page).to have_content "日記"
        link = find('a', text: '日記')
        link.click
        expect(page).to have_content "日記"
      end
    end
  end
  describe '一覧表示機能' do
    let!(:user1){FactoryBot.create(:user1)}
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
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit my_page_path(user1.id)
        expect(page).to have_content "プログラミングの学習"
        all('tbody tr')[0].click_link '削除する'
        page.accept_confirm
        expect(page).not_to have_content "プログラミングの学習"

      end
    end
  end
end