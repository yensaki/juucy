class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by!(uuid: params[:uuid])
  end
end
