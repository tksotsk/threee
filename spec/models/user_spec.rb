require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context '名前、メールアドレス、パスワードのいずれかの情報が入力されない場合' do
      it 'バリデーションにひっかる' do
        user1 = User.new(name: '', email: '', password: '', password_confirmation: '')
        user2 = User.new(name: '鈴木一郎', email: '', password: 'qqqqqqqq', password_confirmation: 'qqqqqqqq')
        user3 = User.new(name: '', email: 'szk1r000@email.com', password: 'qqqqqqqq', password_confirmation: 'qqqqqqqq')
        user4 = User.new(name: '鈴木一郎', email: 'szk1r000@email.com', password: '', password_confirmation: '')
        expect(user1).not_to be_valid
        expect(user2).not_to be_valid
        expect(user3).not_to be_valid
        expect(user4).not_to be_valid
      end
    end
    context 'パスワードが一致しない場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: '鈴木一郎', email: 'szk1r000@email.com', password: 'qqqqqqqq', password_confirmation: 'qqqqqqqp')
        expect(user).not_to be_valid

      end
    end
    context '同じメールアドレスが既に登録している場合' do
      it 'バリデーションに引っかかる' do
        user1 = User.create(name: '鈴木一郎', email: 'szk1r000@email.com', password: 'qqqqqqqq', password_confirmation: 'qqqqqqqq')
        user2 = User.new(name: '須崎色丸', email: 'szk1r000@email.com', password: 'qqqqqqqq', password_confirmation: 'qqqqqqqq')
        expect(user2).not_to be_valid
      end
    end
    context '同じメールアドレスが既に登録している場合' do
      it 'バリデーションに引っかかる' do
        user1 = User.create(name: '鈴木一郎', email: 'szk1r000@email.com', password: 'qqqqqqqq', password_confirmation: 'qqqqqqqq')
        expect(user1).to be_valid
      end
    end
  end
end