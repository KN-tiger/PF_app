class Public::AdminsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @admins = Admin.where(is_deleted: false).page(params[:page]).per(10)
  end
  
  def show
    @admin = Admin.find(params[:id])
  end
  
end
