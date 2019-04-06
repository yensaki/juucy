class CherryPickingJob < ApplicationJob
  queue_as :default

  def perform(movie)
    path =  ActiveStorage::Blob.service.send(:path_for, movie.file.key)
    dest_dir = Rails.root.join('tmp', movie.uuid)
    FileUtils.mkdir_p(dest_dir)
    CherryPickingMoments.uniquish!(path, dest_dir)
    
    Dir.glob(File.join(dest_dir, '*')).each.with_index(1) do |image_path, index|
      File.open(image_path) do |file|
        movie.images = { io: file, filename: "#{index}#{File.extname(file)}" }
      end
    end
  end
end
