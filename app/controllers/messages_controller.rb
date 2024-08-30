class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:create]
  before_action :validate_user!, only: [:create]

  def create
    @message = @room.messages.build(message_params)
    @message.user = current_user

    if @message.save
      @room.broadcast_append_to(
        "messages",
        target: "messages",
        partial: "messages/message",
        locals: { message: @message }
      )
      head :ok
    else
      respond_to do |format|
        format.html { render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity}
      end
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  #部屋に現在グインしているユーザーがいるかどうかを確認する
  def validate_user!
    unless @room && @room.users.include?(current_user)
      redirect_to rooms_path, alert: "You don't have access to this room."
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
