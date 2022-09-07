class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def edit

  end

  def update

  end

  def confirm
  end

  def deactivate

  end

  private

  def admin_params
    params.require(:admin).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :login_id, :is_deleted)
  end
end
