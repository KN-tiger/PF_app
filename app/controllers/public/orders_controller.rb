class Public::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, except: [:index, :new, :confirm]

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_user.cart_items.all
    @total_tax = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.tax_total }
    @total_payment = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    if @order.delivery == "" || @order.deadline == ""
      flash[:alert] = "納品先と納期は必ず入力してください。"
      render :new
    end
  end

  def create
    @order = current_user.orders.new(order_params)
    cart_items = current_user.cart_items.all
    if params[:back] || !@order.save
      render :new
    elsif @order.save
      cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.order_id = @order.id
        order_item.item_id = cart_item.item_id
        order_item.price_with_tax = cart_item.item.price_with_tax
        order_item.amount = cart_item.amount
        order_item.save
      end
      redirect_to orders_complete_path
      cart_items.destroy_all
    end
  end

  def index
    @orders = current_user.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items

  end

  def update
    @order = Order.find(params[:id])
    # 注文ステータスが納品完了になったらすべての発注ステータス：納品完了に変更
    if @order.order_status == "arrived"
      @order.update(order_status: "complete")
      @order.order_items.each do |order_item|
        order_item.update(provision_status: "complete")
      end
      flash[:notice] = "注文ステータスを更新しました。"
    else
      flash[:alert] = "注文ステータスを確認してください。"
    end
    redirect_to order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :delivery, :deadline, :total_payment, :payment_method, :note)
  end

  def ensure_guest_user
    @user = current_user
    if @user.login_id == "guest@example"
      flash[:alert] = "ゲストユーザーはアクセスできません"
      @user.cart_items.destroy_all
      redirect_to items_path
    end
  end
end
