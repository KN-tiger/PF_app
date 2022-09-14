class Public::AdminsController < ApplicationController
  before_action :authenticate_user!

  def index
    @admins = Admin.where.not(login_id: 'guest@example').where(is_deleted: 'false').page(params[:page]).per(10)
    @room = Room.new
  end

  def show
    @admin = Admin.find(params[:id])
    @room = Room.new
  end

end
