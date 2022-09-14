class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    @orders = @user.orders.order(created_at: :desc).limit(5)
  end
  
end
