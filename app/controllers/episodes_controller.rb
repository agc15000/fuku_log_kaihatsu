class EpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cloth, except: [ :timeline ]
  before_action :set_episode, only: %i[ show edit update destroy ]

  def index
    @episodes = @cloth.episodes
  end

  def show
  end

  def new
    @episode = @cloth.episodes.build
  end

  def edit
  end

  def create
    @episode = @cloth.episodes.build(episode_params)
    @episode.user_id = current_user.id
    if @episode.save
      redirect_to cloth_episode_path(@cloth, @episode), notice: "Episode was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @episode.update(episode_params)
        format.html { redirect_to cloth_episode_path(@cloth, @episode), notice: "Episode was successfully updated." }
        format.json { render :show, status: :ok, location: @episode }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @episode.destroy!

    respond_to do |format|
      format.html { redirect_to cloth_episodes_path(@cloth), notice: "Episode was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def timeline
    episodes = current_user.following.map(&:episodes).flatten
    @sorted_episodes = episodes.sort_by(&:created_at).reverse
  end

  private
  # エピソードは洋服に紐づくものなので、現在の洋服ページ情報から洋服のIDを持ってくる
    def set_cloth
      @cloth = current_user.cloths.find(params[:cloth_id])
    end

      def set_episode
        @episode = @cloth.episodes.find(params[:id])
      end

      def episode_params
        params.require(:episode).permit(:cloth_id, :title, :content, :image)
      end
end
