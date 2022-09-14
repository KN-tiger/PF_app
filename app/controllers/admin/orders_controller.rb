class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_order, only: [:show, :update]
  before_action :ensure_guest_user, except: [:index, :show]

  def index
    @orders = Order.order(id: "DESC").page(params[:page]).per(10)
  end

  def show
    @order_items = @order.order_items
  end

  def update
    @order.update(order_params)
    if @order.order_status == "complete"
      @order.order_items.each do |order_item|
        order_item.update(provision_status: "complete")
        # 注文ステータスがすべて納品完了になったら発注ステータス：納品完了に変更
      end
    end
    flash[:notice] = "注文ステータスを更新しました。"
    redirect_to admin_order_path(@order.id)
  end
  

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

  def ensure_order
    @order = Order.find(params[:id])
  end
  
  def ensure_guest_user
    @admin = current_admin
    if @admin.login_id == "guest@example"
      flash[:alert] = "ゲストユーザーはアクセスできません"
      redirect_to admin_root_path
    end
  end
  
end
