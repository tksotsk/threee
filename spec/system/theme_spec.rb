require 'rails_helper'
RSpec.describe 'テーマ管理機能', type: :system do
  describe 'テーマ変更機能' do
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
    context 'テーマ変更画面でテーマを変更した場合' do
      it '変更したテーマが表示される' do
        visit my_page_path(user1.id)
        click_link '健康'
        expect(page).to have_content "睡眠"
        click_link '現在のテーマを変更する'
        fill_in 'theme_second_theme', with: '日記をつける'
        click_button '登録する'
        expect(page).to have_content "日記をつける"
        expect(page).not_to have_content "睡眠"
      end
    end
    context 'テーマ変更画面でテーマを変更しなかった場合' do
      it '変更されずメッセージが現れる' do
        visit my_page_path(user1.id)
        click_link '健康'
        click_link '現在のテーマを変更する'
        click_button '登録する'
        expect(page).to have_content "現在のテーマと同じです"
        visit my_page_path(user1.id)
        click_link '健康'
        expect(page).not_to have_content "日記をつける"
        expect(page).to have_content "睡眠"
      end
    end
    context 'テーマを変更し、前のテーマの画面に戻った場合' do
      it '変更前のテーマの内容が表示される' do
        
        visit my_page_path(user1.id)
        click_link '健康'
        expect(page).to have_content "睡眠"
        click_link '現在のテーマを変更する'
        fill_in 'theme_second_theme', with: '日記をつける'
        click_button '登録する'
        expect(page).to have_content "日記をつける"
        expect(page).not_to have_content "睡眠"
        click_link '前へ'
        expect(page).not_to have_content "日記をつける"
        expect(page).to have_content "睡眠"
      end
    end
    context '変更前のテーマの内容を修正した場合' do
      it '修正した内容が表示される' do
        
        
        visit my_page_path(user1.id)
        click_link '健康'
        click_link '現在のテーマを変更する'
        fill_in 'theme_second_theme', with: '日記をつける'
        click_button '登録する'
        click_link '前へ'
        expect(page).not_to have_content "夜は睡眠をしっかりとる"
        click_link '過去のテーマを修正する'
        fill_in 'theme_second_theme', with: '夜は睡眠をしっかりとる'
        click_button '更新する'
        expect(page).to have_content "夜は睡眠をしっかりとる"
      end
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        
        visit my_page_path(user1.id)
        click_link '健康'
        click_link '現在のテーマを変更する'
        fill_in 'theme_second_theme', with: '日記をつける'
        click_button '登録する'
        click_link '現在のテーマを変更する'
        fill_in 'theme_third_theme', with: 'ジョギング'
        click_button '登録する'
        click_link '履歴'
        expect(page).to have_content "食事"
        expect(page).to have_content "睡眠"
        expect(page).to have_content "運動"
        expect(page).to have_content "日記をつける"
        expect(page).to have_content "ジョギング"
      end
    end
    context '変更して履歴画面に遷移した場合' do
      it '履歴に残った数が表示される' do
        visit my_page_path(user1.id)
        click_link '健康'
        click_link '現在のテーマを変更する'
        fill_in 'theme_second_theme', with: '日記をつける'
        click_button '登録する'
        click_link '現在のテーマを変更する'
        fill_in 'theme_third_theme', with: 'ジョギング'
        click_button '登録する'
        visit my_page_path(user1.id)
        expect(page).to have_content "3"
      end
    end
  end
end