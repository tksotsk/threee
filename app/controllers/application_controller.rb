class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :guest_sign_in, :admin_guest_sign_in]
  before_action :configure_permitted_parameters, if: :devise_controller? 

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email]) # 注目
  end
end
