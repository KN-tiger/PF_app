class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @items = Item.page(params[:page]).per(9)
    @total_items = Item.all
    @genres = Genre.all
  end

  def create
    @item = Item.find(params[:item_id])
    @favorite = @item.favorites.new(user_id: current_user.id)
    unless @favorite.save
      redirect_to request.referer
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @favorite = @item.favorites.find_by(user_id: current_user.id)
    if @favorite.present?
      @favorite.destroy
    else
      redirect_to request.referer
    end
  end
end
