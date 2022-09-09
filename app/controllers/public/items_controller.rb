class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart = Cart.new
    @genres = Genre.all
  end
end
  
