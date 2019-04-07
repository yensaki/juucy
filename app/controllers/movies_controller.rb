class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by!(uuid: params[:uuid])
  end

  def create
    movie = Movie.create!(params.require(:movie).permit(:file))
    redirect_to movie_url(movie.uuid)
  end
end
