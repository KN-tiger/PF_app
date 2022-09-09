class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admin_orders_path
    else
      items_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :users
      root_path
    elsif resource_or_scope == :admin
      admin_root_path
    else
      root_path
    end
  end


 private
    #新規登録時
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
    keys: [:login_id, :first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number])
  end

end
