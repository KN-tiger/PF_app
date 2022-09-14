class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_user, except: [:index, :show, :edit]
  before_action :ensure_admin, except: [:index]

  def index
    @admins = Admin.where.not(login_id: 'guest@example').page(params[:page]).per(10)
  end

  def show

  end

  def edit

  end

  def update
    if @admin.update(admin_params)
      redirect_to admin_admin_path(@admin.id)
      flash[:notice] = "編集した内容を保存しました。"
    else
      flash[:alert] = "編集の保存に失敗しました。"
      render :edit
    end
  end

  def deactivate
    @admin.update(is_deleted: true)
    if @admin.id == current_admin.id
      reset_session
      flash[:notice] = "無効処理を実行しました"
      redirect_to admin_root_path
    else
      redirect_to admin_admins_path
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :login_id, :telephone_number, :is_deleted)
  end

  def ensure_admin
    @admin = Admin.find(params[:id])
  end

  def ensure_guest_user
    @admin = current_admin
    if @admin.login_id == "guest@example"
      flash[:alert] = "ゲストユーザーはアクセスできません"
      redirect_to admin_root_path
    end
  end
end
