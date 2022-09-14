class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_user

  def update
    @order_item = OrderItem.find(params[:id])
    @order = Order.find_by(id: @order_item.order_id)
    @order_item.update(order_item_params)
    if @order.order_items.count == @order.order_items.arranged.count
      @order_item.order.update(order_status: 1)
      # 発注ステータスがすべて発注済になったら注文ステータス：入荷待ちに変更
    elsif @order.order_items.count == @order.order_items.arrived.count
      @order_item.order.update(order_status: 2)
      # 発注ステータスがすべて入荷済になったら注文ステータス：納品可能に変更
    end
    flash[:notice] = "発注ステータスを更新しました。"
    redirect_to admin_order_path(@order)
  end
  
  private

  def order_item_params
    params.require(:order_item).permit(:provision_status)
  end
  
  def ensure_guest_user
    @admin = current_admin
    if @admin.login_id == "guest@example"
      flash[:alert] = "ゲストユーザーはアクセスできません"
      redirect_to admin_root_path
    end
  end
end