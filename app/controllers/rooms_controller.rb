class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
  end

  def create
    #ユーザー間のメッセージを送るための部屋を作成する
    user = User.find(params[:user_id])
    room = Room.create
    room.entries.create(user_id: current_user)
    room.entries.create(user: user)
    redirect_to room_path(room)
  end
end
