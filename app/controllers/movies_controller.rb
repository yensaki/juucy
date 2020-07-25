class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by!(uuid: params[:uuid])
  end

  def create
    form = MovieForm.new(file: params.require(:movie)[:file])
    form.save!

    redirect_to movie_url(form.movie.uuid)
  end
end
