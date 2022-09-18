class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_user, except: [:index, :edit]



  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def ensure_guest_user
    @admin = current_admin
    if @admin.login_id == "guest@example"
      flash[:alert] = "ゲストユーザーはアクセスできません"
      redirect_to admin_root_path
    end
  end

end
