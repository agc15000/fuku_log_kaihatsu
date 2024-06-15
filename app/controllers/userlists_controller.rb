class UserlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end
end
