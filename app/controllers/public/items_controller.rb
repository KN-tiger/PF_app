class Public::ItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @items = Item.page(params[:page]).per(9)
    @total_items = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end

