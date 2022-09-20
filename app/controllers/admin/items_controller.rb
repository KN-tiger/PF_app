class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_user, except: [:index, :show, :edit, :new]

  def index
    @items = Item.page(params[:page]).per(8)
    @total_items = Item.all
  end

  def new
    @item_new = Item.new
    @genres = Genre.all
    @tags = Tag.all
  end

  def create
    @item_new = Item.new(item_params)
    tag_list = params[:item][:tag_ids].split(',')
    if @item_new.save
      @item_new.save_tags(tag_list)
      flash[:notice] = "商品を登録しました"
      redirect_to admin_item_path(@item_new)
    else
      flash[:alert] = "商品の登録に失敗しました"
      @genres = Genre.all
      @tags = Tag.all
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @tag_list =@item.tags.pluck(:tag_name).join(",")
    @genres = Genre.all
    @tags = Tag.all
  end

  def update
    @item = Item.find(params[:id])
    tag_list = params[:item][:tag_ids].split(',')
    if @item.update(item_params)
      @item.save_tags(tag_list)
      flash[:notice] = "商品情報を変更しました"
      redirect_to admin_item_path(@item)
    else
      # DBエラ－対策
      @item_old_image = Item.find(params[:id])
      @genres = Genre.all
      flash[:alert] = "商品情報の変更に失敗しました"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price_without_tax, :is_stopped, :detail, :image, tag_ids: [])
  end

  def ensure_guest_user
    @admin = current_admin
    if @admin.login_id == "guest@example"
      flash[:alert] = "ゲストユーザーはアクセスできません"
      redirect_to admin_root_path
    end
  end
end
