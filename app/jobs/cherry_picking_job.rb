class CherryPickingJob < ApplicationJob
  queue_as :default

  def perform(movie)
    path =  ActiveStorage::Blob.service.send(:path_for, movie.file.key)
    dest_dir = Rails.root.join('tmp', movie.uuid)
    FileUtils.mkdir_p(dest_dir)
    CherryPickingMoments.uniquish!(path, dest_dir)
    
    Dir.glob(File.join(dest_dir, '*')).each do |image_path|
      puts image_path
    end
  end
end
