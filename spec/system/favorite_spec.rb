require 'rails_helper'
RSpec.describe 'お気に入り機能', type: :system do
  describe 'お気に入り機能（一覧画面）' do
    let!(:user1){FactoryBot.create(:user1)}
    let!(:user2){FactoryBot.create(:user2)}
    let!(:project1){FactoryBot.create(:project1, user_id: user1.id)}
    let!(:theme1){FactoryBot.create(:theme1, project_id: project1.id)}
    let!(:project2){FactoryBot.create(:project2, user_id: user1.id)}
    let!(:theme2){FactoryBot.create(:theme2, project_id: project2.id)}
    before do
      visit new_user_session_path
      fill_in '名前', with: "user2"
      fill_in 'パスワード', with: "qqqqqqqq"
      button = find('.login')
      button.click
    end
    context 'プロジェクト一覧画面でお気に入りボタン（❤）を押した場合' do
      it 'お気に入り登録される' do
        visit projects_path
        all('tbody tr')[1].click_link '❤'
        sleep 1.0
        favorite = Favorite.where(user_id: user2.id, project_id: project1.id)
        expect(favorite.length).to eq 1

      end
    end
    context 'プロジェクト一覧画面で既に押してあるお気に入りボタン（❤）を押した場合' do
      it '登録されていたお気に入りが解除される' do
        
        visit projects_path
        all('tbody tr')[0].click_link '❤'
        sleep 1.0
        visit projects_path
        all('tbody tr')[0].click_link '❤'
        sleep 1.0
        favorite = Favorite.where(user_id: user2.id, project_id: project2.id)
        expect(favorite.length).to eq 0
      end
    end
    context 'プロジェクト一覧画面でお気に入りボタン（❤）を押した場合' do
      it 'お気に入り一覧画面に追加される' do
        
        visit projects_path
        click_link 'お気に入りのプロジェクト'
        expect(page).not_to have_content "健康"
        visit projects_path
        all('tbody tr')[1].click_link '❤'
        click_link 'お気に入りのプロジェクト'
        expect(page).to have_content "健康"
      end
    end
    context 'プロジェクト（テーマ）閲覧画面でお気に入りボタン（❤）を押した場合' do
      it 'お気に入り登録される' do
        visit projects_path
        click_link '健康'
        click_link '❤'
        sleep 1.0
        favorite = Favorite.where(user_id: user2.id, project_id: project1.id)
        expect(favorite.length).to eq 1
      end
    end
    context 'プロジェクト（テーマ）閲覧画面で既に押しているお気に入りボタン（❤）を押した場合' do
      it '登録されていたお気に入りが解除される' do
        visit projects_path
        click_link '健康'
        click_link '❤'
        sleep 1.0
        click_link '❤'
        sleep 1.0
        favorite = Favorite.where(user_id: user2.id, project_id: project2.id)
        expect(favorite.length).to eq 0
      end
    end
    context 'プロジェクト（テーマ）閲覧画面でお気に入りボタン（❤）を押した場合' do
      it 'お気に入り一覧画面に追加される' do
        visit favorites_path
        expect(page).not_to have_content "健康"
        visit projects_path
        click_link '健康'
        click_link '❤'
        visit favorites_path
        expect(page).to have_content "健康"
      end
    end
  end
end