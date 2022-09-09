class Admin::HomesController < ApplicationController
  
  def top
    redirect_to new_admin_session_path
  end
  
end
