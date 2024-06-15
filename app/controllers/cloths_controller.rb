class ClothsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cloth, only: %i[show edit update destroy]

  def index
    @cloths = current_user.cloths
  end

  def show
  end

  def new
    @cloth = Cloth.new
  end

  def edit
  end

  def create
    @cloth = current_user.cloths.build(cloth_params)

    if @cloth.save
      redirect_to cloths_path, notice: 'Cloth was successfully created.'
    else
      render :new
    end
  end

  def update
    if @cloth.update(cloth_params)
      redirect_to @cloth, notice: 'Cloth was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @cloth.destroy
    redirect_to cloths_url, notice: 'Cloth was successfully destroyed.'
  end

  private

  def set_cloth
    @cloth = Cloth.find(params[:id])
  end

  def cloth_params
    params.require(:cloth).permit(:name, :description, :image, :tag_list)
  end
end
