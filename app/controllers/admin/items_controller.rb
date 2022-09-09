class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all.page(params[:page]).per(10)
  end

  def new
    @item_new = Item.new
    @genres = Genre.all
  end

  def create
    @item_new = Item.new(item_params)
    if @item_new.save
      redirect_to admin_item_path(@item_new), notice: "商品が登録されました。"
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "変更内容が保存されました。"
    else
      @genres = Genre.all
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:images, :genre_id, :name, :introduction, :price_without_tax, :is_stopped)
  end

  
end
