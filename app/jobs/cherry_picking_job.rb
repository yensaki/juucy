require 'open-uri'

class CherryPickingJob < ApplicationJob
  queue_as :default

  def perform(movie)
    file = open(movie.file.blob.service_url)
    dest_dir = Rails.root.join('tmp', movie.uuid)
    FileUtils.mkdir_p(dest_dir)
    picking_movie = CherryPickingMoments.movie(file.path)

    picking_movie.images.each.with_index(1) do |image, index|
      File.open(image.filepath).each do |file|
        movie.images = { io: file, filename: "#{index}#{File.extname(file)}" }
      end
    end
  end
end
