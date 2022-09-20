class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "注文"
      @orders = Order.search(params[:word]).order(id: "DESC").page(params[:page]).per(10)
    elsif @range == "事務員"
      @admins = Admin.where.not(login_id: 'guest@example').search(params[:word]).page(params[:page]).per(10)
    elsif @range == "営業"
      @users = User.where.not(login_id: 'guest@example').search(params[:word]).page(params[:page]).per(10)
    elsif  @range == "商品"
      @items = Item.search(params[:word]).page(params[:page]).per(10)
    end
  end

end
