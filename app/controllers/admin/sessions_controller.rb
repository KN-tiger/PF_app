# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_admin, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_inactive_admin
    @admin = Admin.find_by(login_id: params[:admin][:login_id])
    if @admin
      if @admin.valid_password?(params[:admin][:password]) && @admin.is_deleted
        flash[:alert] = 'IDが無効になっています。'
        redirect_to new_admin_session_path
      end
    end
  end
end
