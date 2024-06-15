class ApplicationController < ActionController::Base
  before_action :set_ransack_search
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_ransack_search
    @q = User.ransack(params[:q])
    @cloth_search = Cloth.ransack(params[:cloth_search])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile ,:current_password])
  end
end
