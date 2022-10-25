require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user1){FactoryBot.create(:user1)}
    context 'プロジェクト情報が入力されない場合' do
      it 'バリデーションにひっかる' do
        project = Project.new(title: '',user_id: user1.id)
        expect(project).not_to be_valid
      end
    end
    context 'プロジェクト情報が入力されている場合' do
      it 'バリデーションが通る' do
        project = Project.new(title: '食事',user_id: user1.id)
        expect(project).to be_valid
      end
    end
  end
end