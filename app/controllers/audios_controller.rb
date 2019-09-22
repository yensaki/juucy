class AudiosController < ApplicationController
  before_action :set_movie

  def index
  end

  private

  def set_movie
    @movie = Movie.find_by!(uuid: params[:movie_uuid])
  end
end
