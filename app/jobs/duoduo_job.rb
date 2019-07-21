require 'open-uri'

class DuoduoJob < ApplicationJob
  queue_as :default

  def perform(movie)
    file = open(movie.file.blob.service_url)
    extfilepath = File.join(Dir.tmpdir, "#{movie.uuid}.mp3")
    Open3.capture3("ffmpeg -i '#{file.path}' -vn -acodec libmp3lame '#{extfilepath}'")
    duoaudio = Duoduo::Audio.new(extfilepath)

    duoaudio.pieces.each do |piece|
      file = File.open(piece.filepath)
      filename = File.basename(piece.filepath)
      movie.audios.create!(file: { io: file, filename: filename })
    end
  end
end
