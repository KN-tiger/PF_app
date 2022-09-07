class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

 private
    #新規登録時
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
      keys: [:login_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number])
    end
  end
