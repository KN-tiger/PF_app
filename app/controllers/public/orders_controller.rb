class Public::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, except: [:new, :confirm]

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_user.cart_items.all
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
  end

  def create
    cart_items = current_user.cart_items.all
    @order = current_user.orders.new(order_params)
    if @order.save
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
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def index
    @orders = Kaminari.paginate_array(current_user.orders.reverse).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
    @order_items.each do |item|
      @total += ( item.price_with_tax * item.amount )
    end
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :postage, :total_payment)
  end

  def destination_params
    params.require(:destination).permit(:user_id, :postal_code, :address, :name)
  end

  def ensure_user
    if current_user.login_id == "guest@sample"
      current_user.cart_items.destroy_all
      flash[:alert] = "ゲストユーザーは注文できません。"
      redirect_to items_path
    end
  end
end
