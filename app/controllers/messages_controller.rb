class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:create]
  before_action :validate_user_in_room, only: [:create]

  def create
    @message = @room.messages.build(message_params)
    @message.user = current_user
    if @message.save
      RoomChannel.broadcast_to(@room, message: @message.content, user: @message.user.email)
      head :ok
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def validate_user_in_room!
    unless @room.users.include?(current_user)
      render file: 'public/404.html', status: :not_found
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
