require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user1){FactoryBot.create(:user1)}
    let!(:project1){FactoryBot.create(:project1, user_id: user1.id)}
    context 'いずれかのテーマ情報が入力されない場合' do
      it 'バリデーションにひっかる' do
        theme1 = Theme.new(first_theme: '食事', second_theme: '睡眠', third_theme: '', project_id: project1.id)
        theme2 = Theme.new(first_theme: '食事', second_theme: '', third_theme: '運動', project_id: project1.id)
        theme3 = Theme.new(first_theme: '', second_theme: '睡眠', third_theme: '運動', project_id: project1.id)
        expect(theme1).not_to be_valid
        expect(theme2).not_to be_valid
        expect(theme3).not_to be_valid
      end
    end
    context 'いずれかのテーマ情報が入力されている場合' do
      it 'バリデーションが通る' do
        theme = Theme.new(first_theme: '食事', second_theme: '睡眠', third_theme: '運動', project_id: project1.id)
        expect(theme).to be_valid
      end
    end
  end
end