class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.page(params[:page]).per(9)
    @total_favorites = current_user.favorites
    @genres = Genre.all
  end

  def create
    @item = Item.find(params[:item_id])
    @favorite = @item.favorites.new(user_id: current_user.id)
    @favorite.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    @favorite = @item.favorites.find_by(user_id: current_user.id)
    if @favorite.present?
      @favorite.destroy
    #   redirect_to request.referer
    end
  end
end
