class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_user, except: [:index, :edit]
  def index
    @genres = Genre.all
    @genre_new = Genre.new
  end
  
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id).page(params[:page]).per(9)
  end

  def create
    @genre_new = Genre.new(genre_params)
    if @genre_new.save
      redirect_to admin_genres_path
      flash[:notice] = "ジャンル名を追加しました。"
    else
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
      flash[:notice] = "編集した内容を保存しました。"
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def ensure_guest_user
    @admin = current_admin
    if @admin.login_id == "guest@example"
      flash[:alert] = "ゲストユーザーはアクセスできません"
      redirect_to admin_root_path
    end
  end
  
end
