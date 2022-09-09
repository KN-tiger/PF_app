class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_user, except: [:index]
  
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
      flash[:notice] = "編集した内容を保存しました。"
    else
      render :edit
    end
  end
  
  def deactivate
    @user.update(is_deleted: true)
    flash[:notice] = "無効処理を実行しました"
    redirect_to admin_users_path
  end

  def order_history
    @orders = @user.orders.order(id: "DESC").page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :login_id, :telephone_number, :is_deleted)
  end
  
  def ensure_user
    @user = User.find(params[:id])
  end

end
