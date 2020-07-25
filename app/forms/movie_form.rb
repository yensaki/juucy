class MovieForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :file

  attr_reader :movie

  def save!
    @movie = Movie.create!(file: file)
    # CherryPickingJob.perform_later(@movie)
  end
end
