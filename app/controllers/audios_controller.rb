class AudiosController < ApplicationController
  before_action :set_movie
  before_action :set_audio, only: %i(edit update)

  def index
  end

  def edit
  end

  def update
    @audio.words = params.dig(:audio, :words)

    if @audio.save
      redirect_to movie_audios_url(@movie.uuid)
    else
      render :edit
    end
  end

  private

  def set_movie
    @movie = Movie.find_by!(uuid: params[:movie_uuid])
  end

  def set_audio
    @audio = @movie.audios.find(params[:id])
  end
end
