class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all.page(params[:page]).per(8)
  end

  def new
    @item_new = Item.new
    @genres = Genre.all
  end

  def create
    @item_new = Item.new(item_params)
    if @item_new.save
      flash[:notice] = "商品を登録しました"
      redirect_to admin_item_path(@item)
    else
      flash[:alert] = "商品の登録に失敗しました"
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
      flash[:notice] = "商品情報を変更しました"
      redirect_to admin_item_path(@item)
    else
      @item_old_image = Item.find(params[:id])
      @genres = Genre.all
      flash[:alert] = "商品情報の変更に失敗しました"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price_without_tax, :is_stopped, :image)
  end

end
