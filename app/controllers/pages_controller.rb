class PagesController < ApplicationController

  def top
  end

  def guest_sign_in
    user = User.find_or_create_by!(name: "guest") do |user|
      user.email = "guest@example.com"
      user.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def admin_guest_sign_in
    user = User.find_or_create_by!(name: "admin") do |user|
      user.email = "admin_guest@example.com"
      user.password = SecureRandom.urlsafe_base64
      user.admin = true
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: '管理者ゲストユーザーとしてログインしました。'
  end
end
