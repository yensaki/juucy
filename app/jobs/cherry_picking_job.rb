require 'open-uri'

class CherryPickingJob < ApplicationJob
  queue_as :default

  def perform(movie)
    file = open(movie.file.blob.service_url)
    dest_dir = Rails.root.join('tmp', movie.uuid)
    FileUtils.mkdir_p(dest_dir)
    CherryPickingMoments.uniquish!(file.path, dest_dir)
    
    Dir.glob(File.join(dest_dir, '*')).each.with_index(1) do |image_path, index|
      File.open(image_path) do |file|
        movie.images = { io: file, filename: "#{index}#{File.extname(file)}" }
      end
    end
  end
end
