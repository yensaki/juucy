class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by!(uuid: params[:uuid])
  end

  def create
    # TODO: to be Form
    movie = Movie.create!(params.require(:movie).permit(:file))
    CherryPickingJob.perform_later(movie)
    redirect_to movie_url(movie.uuid)
  end
end
