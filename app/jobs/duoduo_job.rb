require 'open-uri'

class DuoduoJob < ApplicationJob
  queue_as :default

  def perform(movie)
    file = open(movie.file.blob.service_url)
    extfilepath = File.join(Dir.tmpdir, "#{movie.uuid}.wav")
    Open3.capture3("ffmpeg -i '#{file.path}' -vn -acodec pcm_s16le -ac 1 -ar 48000 '#{extfilepath}'")
    duoaudio = Duoduo::Audio.new(extfilepath, extension: 'wav')

    monodir = File.join(Dir.tmpdir, "mono_#{movie.uuid}")
    FileUtils.mkdir_p(monodir)
    duoaudio.pieces.each.with_index do |piece, index|
      monofilename = "#{index}.wav"
      monopath = File.join(monodir, monofilename)
      Open3.capture3("ffmpeg -i '#{piece.filepath}' -ac 1 '#{monopath}'")
      movie.audios.create!(file: { io: File.open(monopath), filename: monofilename })
    end
  end
end
