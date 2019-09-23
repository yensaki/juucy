class ImagesController < ApplicationController
  before_action :set_movie

  def index
    @images = @movie.images.page(params[:page]).per(20)
  end

  private

  def set_movie
    @movie = Movie.find_by!(uuid: params[:movie_uuid])
  end
end
