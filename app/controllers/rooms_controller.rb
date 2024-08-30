class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show]
  before_action :validate_user!, only: [:show]

  def index
    @rooms = current_user.rooms
  end

  def create
    #ユーザー間のメッセージを送るための部屋を作成する
    user = User.find(params[:user_id])
    room = Room.create
    room.entries.create(user_id: current_user.id)
    room.entries.create(user_id: user.id)
    redirect_to room_path(room)
  end

  def show
    @messages = @room.messages.includes(:user)
  end

  private

  def set_room
    @room = Room.find_by(id: params[:id])
  end

  def validate_user!
    unless @room && @room.users.include?(current_user)
      redirect_to rooms_path, alert: "You don't have access to this room."
    end
  end
end
