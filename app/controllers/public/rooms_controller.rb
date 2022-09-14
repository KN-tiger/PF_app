class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @admin = Admin.find_by(id: params[:room][:admin_id])
    rooms = current_user.entries.pluck(:room_id)
    ensure_entry = Entry.find_by(admin_id: @admin.id, room_id: rooms)
    if ensure_entry.nil?
      @room = Room.new
      @room.save
      Entry.create(user_id: current_user.id, admin_id: @admin.id, room_id: @room.id)
      redirect_to room_path(@room)
    else
      @room = ensure_entry.room
      redirect_to room_path(@room)
    end
  end

  def index
    current_entries = current_user.entries
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    @another_entries = Entry.where(room_id: my_room_id)
  end


  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages.all
      @message = Message.new
      @entries = @room.entries
      @another_entry = @room.entries.find_by('user_id != ?', current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
end
